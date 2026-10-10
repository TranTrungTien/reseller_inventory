// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/bin_badge.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/di/providers.dart';
import '../../../core/domain/value_objects/enums.dart';
import '../../../core/qr/qr_service.dart';
import '../../../core/scanner/shared_scanner_view.dart';
import '../../../core/sync/sync_foundation.dart';
import '../../inventory/domain/inventory_event.dart';
import '../../inventory/domain/item.dart';
import 'pick_list_page.dart';

class PickSessionPage extends ConsumerStatefulWidget {
  const PickSessionPage({super.key});

  @override
  ConsumerState<PickSessionPage> createState() => _PickSessionPageState();
}

class _PickSessionPageState extends ConsumerState<PickSessionPage> {
  int _currentIndex = 0;
  String? _wrongBinErrorMessage;
  bool _isSuccessFlash = false;

  void _triggerSuccessFlash() {
    setState(() => _isSuccessFlash = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isSuccessFlash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final readyAsync = ref.watch(readyToPickProvider);
    final scannerState = ref.watch(scannerControllerProvider);
    final scannerNotifier = ref.read(scannerControllerProvider.notifier);
    final binRepo = ref.watch(binRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Session'),
      ),
      body: SafeArea(
        child: readyAsync.when(
          data: (items) {
            if (items.isEmpty || _currentIndex >= items.length) {
              return EmptyState(
                title: 'Pick Session Complete!',
                message: 'All sold items have been picked and verified.',
                icon: Icons.check_circle_outline,
                action: AppButton(
                  label: 'Return to Dashboard',
                  onPressed: () => context.go('/'),
                ),
              );
            }

            final currentItem = items[_currentIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Item & Target Bin Card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ITEM ${_currentIndex + 1} OF ${items.length}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.grey),
                          ),
                          BinBadge(code: currentItem.binId ?? 'A01'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        currentItem.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'SKU: ${currentItem.sku}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // WRONG BIN Warning Banner
                if (_wrongBinErrorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    color: Colors.red.shade900,
                    child: Row(
                      children: [
                        const Icon(Icons.warning,
                            color: Colors.yellow, size: 24),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            _wrongBinErrorMessage!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Camera Scanner
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: SharedScannerView(
                          state: scannerState,
                          controller: scannerNotifier,
                          overlayTitle:
                              'Scan Expected Bin ${currentItem.binId ?? ''}',
                          onDetect: (capture) async {
                            final barcodes = capture.barcodes;
                            if (barcodes.isNotEmpty) {
                              final rawValue = barcodes.first.rawValue;
                              if (rawValue != null) {
                                final resolution = await scannerNotifier
                                    .handleScannedCode(rawValue, binRepo);
                                if (resolution != null) {
                                  await _verifyAndPickItem(
                                      currentItem, resolution);
                                }
                              }
                            }
                          },
                        ),
                      ),
                      if (_isSuccessFlash)
                        Container(color: Colors.green.withValues(alpha: 0.35)),
                    ],
                  ),
                ),

                // Manual Override / Next CTA
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: AppButton(
                    label: 'Manual Confirm Pick',
                    icon: Icons.check,
                    isSecondary: true,
                    isFullWidth: true,
                    onPressed: () async {
                      await _confirmPickSuccess(currentItem);
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }

  Future<void> _verifyAndPickItem(
    Item item,
    QrResolution resolution,
  ) async {
    if (resolution.status != QrResolutionStatus.valid ||
        resolution.bin == null) {
      _triggerWrongBinError(
          'INVALID QR CODE! Expected Bin ${item.binId ?? ''}');
      return;
    }

    final scannedBin = resolution.bin!;

    // Check if scanned bin matches expected bin (comparing bin ID or bin code)
    if (scannedBin.id == item.binId ||
        scannedBin.code.toUpperCase() == (item.binId ?? '').toUpperCase()) {
      setState(() => _wrongBinErrorMessage = null);
      await _confirmPickSuccess(item);
    } else {
      _triggerWrongBinError(
          'WRONG BIN!\nExpected Bin ${item.binId ?? ''}, Scanned Bin ${scannedBin.code}');
    }
  }

  void _triggerWrongBinError(String message) {
    HapticFeedback.vibrate();
    setState(() {
      _wrongBinErrorMessage = message;
    });
  }

  Future<void> _confirmPickSuccess(Item item) async {
    _triggerSuccessFlash();
    HapticFeedback.mediumImpact();

    final itemRepo = ref.read(itemRepositoryProvider);
    final invRepo = ref.read(inventoryRepositoryProvider);
    final syncEngine = ref.read(syncEngineProvider);
    final now = DateTime.now();

    // 1. Update status
    final pickedItem = item.copyWith(
      status: ItemStatus.picked,
      updatedAt: now,
    );
    await itemRepo.saveItem(pickedItem);

    // 2. Write immutable InventoryEvent
    await invRepo.recordEvent(
      InventoryEvent(
        id: const Uuid().v4(),
        workspaceId: item.workspaceId,
        itemId: item.id,
        type: InventoryEventType.picked,
        fromLocationId: item.locationId,
        fromBinId: item.binId,
        note: 'Verified & Picked during Pick Session',
        occurredAt: now,
      ),
    );

    // 3. Outbox Sync Operation
    await syncEngine.enqueueOperation(
      workspaceId: item.workspaceId,
      entityType: 'item',
      entityId: item.id,
      operationType: SyncOperationType.update,
      payload: {'id': item.id, 'status': 'picked'},
    );

    ref.invalidate(readyToPickProvider);

    setState(() {
      _wrongBinErrorMessage = null;
      _currentIndex = _currentIndex + 1;
    });
  }
}
