import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/bin_badge.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/di/providers.dart';
import '../../../core/domain/value_objects/money.dart';
import '../../../core/qr/qr_service.dart';
import '../../../core/scanner/shared_scanner_view.dart';
import '../../../core/widgets/page_header.dart';
import '../../bins/domain/bin.dart';
import 'turbo_intake_controller.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  bool _isFlashing = false;

  void _triggerFlashAnimation() {
    setState(() => _isFlashing = true);
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _isFlashing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final turboState = ref.watch(turboIntakeControllerProvider);
    final turboNotifier = ref.read(turboIntakeControllerProvider.notifier);

    return SafeArea(
      child: turboState.isBinLocked
          ? _buildLockedCaptureView(context, turboState, turboNotifier)
          : _buildBinLockingView(context, turboNotifier),
    );
  }

  Widget _buildBinLockingView(
      BuildContext context, TurboIntakeController turboNotifier) {
    final scannerState = ref.watch(scannerControllerProvider);
    final scannerNotifier = ref.read(scannerControllerProvider.notifier);
    final binRepo = ref.watch(binRepositoryProvider);
    final workspaceId = ref.watch(currentWorkspaceIdProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PageHeader(
          'Turbo Intake',
          subtitle: 'Scan a bin once, then capture continuously.',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: SharedScannerView(
              state: scannerState,
              controller: scannerNotifier,
              overlayTitle: 'Scan Bin to Lock Destination',
              onDetect: (capture) async {
                final barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final rawValue = barcodes.first.rawValue;
                  if (rawValue != null) {
                    final resolution = await scannerNotifier.handleScannedCode(
                        rawValue, binRepo);
                    if (resolution != null &&
                        resolution.status == QrResolutionStatus.valid &&
                        resolution.bin != null) {
                      final bin = resolution.bin!;
                      turboNotifier.lockBin(
                        workspaceId: workspaceId,
                        locationId: bin.locationId,
                        binId: bin.id,
                        binCode: bin.code,
                        locationName: bin.description ?? 'Location',
                      );
                    } else if (resolution != null && context.mounted) {
                      _showFeedback(context,
                          resolution.errorMessage ?? 'Cannot lock bin.');
                    }
                  }
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: AppButton(
            label: 'Select Bin Manually',
            icon: Icons.all_inbox,
            isSecondary: true,
            isFullWidth: true,
            onPressed: () =>
                _showSelectBinBottomSheet(context, ref, turboNotifier),
          ),
        ),
      ],
    );
  }

  Widget _buildLockedCaptureView(
    BuildContext context,
    TurboIntakeState state,
    TurboIntakeController notifier,
  ) {
    final session = state.session!;
    final scannerState = ref.watch(scannerControllerProvider);
    final scannerNotifier = ref.read(scannerControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Locked Destination Bar
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl, vertical: AppSpacing.md),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BinBadge(
                            code: session.binCode,
                            locationName: session.locationName),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          '${session.sessionCount} Items Added',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    if (session.effectiveCostPerItem != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Default Cost: ${session.effectiveCostPerItem!.format('en_US')}',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade700),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.attach_money),
                tooltip: 'Cost & Haul Settings',
                onPressed: () =>
                    _showCostShortcutModal(context, session, notifier),
              ),
              IconButton(
                icon: const Icon(Icons.lock_open),
                tooltip: 'Switch Bin',
                onPressed: () => notifier.unlockBin(),
              ),
            ],
          ),
        ),
        const Divider(height: 1),

        // Error / Retry Banner
        if (state.errorMessage != null)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            color: Colors.red.shade900,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () => notifier.retryPendingCapture(),
                  child: const Text('RETRY',
                      style: TextStyle(
                          color: Colors.yellow, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

        // Continuous Camera Feed
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: SharedScannerView(
                  state: scannerState,
                  controller: scannerNotifier,
                  overlayTitle: 'Turbo Intake Active',
                  onDetect: (_) {},
                ),
              ),
              if (_isFlashing)
                Container(
                  color: Colors.green.withValues(alpha: 0.35),
                ),
            ],
          ),
        ),

        // Horizontal Recent Photos Strip
        if (session.photosAdded.isNotEmpty) ...[
          SizedBox(
            height: 72,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              scrollDirection: Axis.horizontal,
              itemCount: session.photosAdded.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final photo =
                    session.photosAdded[session.photosAdded.length - 1 - index];
                return Container(
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.borderMd,
                    border: Border.all(color: Colors.black12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: photo.localPath != null &&
                          File(photo.localPath!).existsSync()
                      ? Image.file(File(photo.localPath!), fit: BoxFit.cover)
                      : const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],

        // Fast Capture CTA
        Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: AppButton(
            label: state.isCapturing ? 'SAVING ITEM...' : 'CAPTURE ITEM PHOTO',
            icon: Icons.add_a_photo,
            isFullWidth: true,
            onPressed: state.isCapturing
                ? null
                : () async {
                    final captureService =
                        ref.read(imageCaptureServiceProvider);
                    final photoFile =
                        await captureService.capturePhotoFromCamera();
                    if (photoFile != null) {
                      _triggerFlashAnimation();
                      final success = await notifier.capturePhoto(photoFile);
                      if (!success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Failed to save item locally. Tap Retry.')),
                        );
                      }
                    }
                  },
          ),
        ),
      ],
    );
  }

  void _showSelectBinBottomSheet(
      BuildContext context, WidgetRef ref, TurboIntakeController notifier) {
    final workspaceId = ref.read(currentWorkspaceIdProvider);
    final binRepo = ref.read(binRepositoryProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FutureBuilder<List<Bin>>(
        future: binRepo.getBinsForWorkspace(workspaceId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final bins = snapshot.data!;
          if (bins.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: EmptyState(
                title: 'No bins available',
                message: 'Create a bin first in the Bins tab.',
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Select Destination Bin',
                  style: Theme.of(ctx)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.md),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: bins.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.xs),
                    itemBuilder: (context, index) {
                      final bin = bins[index];
                      return ListTile(
                        leading: const Icon(Icons.all_inbox),
                        title: Text('Bin ${bin.code}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(bin.description ??
                            'Location ID: ${bin.locationId}'),
                        onTap: () {
                          notifier.lockBin(
                            workspaceId: workspaceId,
                            locationId: bin.locationId,
                            binId: bin.id,
                            binCode: bin.code,
                            locationName: bin.description ?? 'Location',
                          );
                          Navigator.pop(ctx);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showCostShortcutModal(
      BuildContext context, session, TurboIntakeController notifier) {
    final defaultCostController = TextEditingController(
      text: session.defaultCost != null
          ? session.defaultCost!.amountInMajorUnits.toStringAsFixed(2)
          : '',
    );
    final haulTotalController = TextEditingController();
    final haulCountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          MediaQuery.viewInsetsOf(ctx).bottom + AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Cost Shortcuts & Haul Allocation',
              style: Theme.of(ctx)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: defaultCostController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Fixed Cost Per Item (\$)',
                hintText: 'e.g. 5.00',
              ),
            ),
            const Divider(height: 32),
            Text(
              'OR Split Total Haul Cost',
              style: Theme.of(ctx)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: haulTotalController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        labelText: 'Total Haul (\$)', hintText: '100.00'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: haulCountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Item Count', hintText: '20'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Apply Cost Shortcut',
              onPressed: () {
                final defCostText = defaultCostController.text.trim();
                final totalText = haulTotalController.text.trim();
                final countText = haulCountController.text.trim();

                if (defCostText.isNotEmpty) {
                  final val = double.tryParse(defCostText);
                  if (val != null) {
                    notifier.setCostShortcut(
                        defaultCost: Money.fromMajorUnits(val, 'USD'));
                  }
                } else if (totalText.isNotEmpty && countText.isNotEmpty) {
                  final totalVal = double.tryParse(totalText);
                  final countVal = int.tryParse(countText);
                  if (totalVal != null && countVal != null && countVal > 0) {
                    notifier.setCostShortcut(
                      totalHaulCost: Money.fromMajorUnits(totalVal, 'USD'),
                      haulItemCount: countVal,
                    );
                  }
                } else {
                  notifier.setCostShortcut(
                      defaultCost: null,
                      totalHaulCost: null,
                      haulItemCount: null);
                }
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
