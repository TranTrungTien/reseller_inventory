import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/bin_badge.dart';
import '../../../core/di/providers.dart';
import '../../../core/domain/value_objects/enums.dart';
import '../../../core/sync/sync_foundation.dart';
import '../../bins/domain/bin.dart';
import '../domain/inventory_event.dart';
import '../domain/item.dart';

class CantFindModal extends ConsumerWidget {
  const CantFindModal({
    super.key,
    required this.item,
    required this.historyEvents,
    required this.onStatusChanged,
  });

  final Item item;
  final List<InventoryEvent> historyEvents;
  final VoidCallback onStatusChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.search_off, color: Colors.orange, size: 28),
              const SizedBox(width: AppSpacing.md),
              Text(
                "Can't Find Item",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Current Recorded Location Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('CURRENT RECORDED LOCATION',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (item.binId != null) BinBadge(code: item.binId!),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Location ID: ${item.locationId ?? 'Default'}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Recent Physical Move History
          if (historyEvents.isNotEmpty) ...[
            Text(
              'RECENT MOVE HISTORY',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
            ),
            const SizedBox(height: AppSpacing.xs),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: historyEvents.length.clamp(0, 3),
                separatorBuilder: (_, __) => const Divider(height: 12),
                itemBuilder: (context, index) {
                  final evt = historyEvents[index];
                  return Row(
                    children: [
                      const Icon(Icons.history, size: 16, color: Colors.grey),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          '${evt.type.name.toUpperCase()} - ${evt.note ?? 'Location change'}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],

          // Actions
          AppButton(
            label: 'MARK MISSING',
            icon: Icons.warning_amber_rounded,
            onPressed: () async {
              await _markItemMissing(context, ref);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Search Another Location / Move',
            icon: Icons.swap_horiz,
            isSecondary: true,
            onPressed: () {
              Navigator.pop(context);
              _showMoveLocationPicker(context, ref);
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _markItemMissing(BuildContext context, WidgetRef ref) async {
    final itemRepo = ref.read(itemRepositoryProvider);
    final invRepo = ref.read(inventoryRepositoryProvider);
    final syncEngine = ref.read(syncEngineProvider);
    final analytics = ref.read(analyticsServiceProvider);
    final now = DateTime.now();

    final previousStatus = item.status;

    // 1. Update item status to missing
    final missingItem = item.copyWith(
      status: ItemStatus.missing,
      updatedAt: now,
    );
    await itemRepo.saveItem(missingItem);

    // 2. Write immutable InventoryEvent
    await invRepo.recordEvent(
      InventoryEvent(
        id: const Uuid().v4(),
        workspaceId: item.workspaceId,
        itemId: item.id,
        type: InventoryEventType.markedMissing,
        fromLocationId: item.locationId,
        fromBinId: item.binId,
        note: 'Marked as missing in Can\'t Find dialog',
        occurredAt: now,
      ),
    );

    // 3. Durable Outbox Sync Operation
    await syncEngine.enqueueOperation(
      workspaceId: item.workspaceId,
      entityType: 'item',
      entityId: item.id,
      operationType: SyncOperationType.update,
      payload: {'id': item.id, 'status': 'missing'},
    );

    // 4. Analytics logging
    analytics.logItemMarkedMissing(item.id, item.binId);

    onStatusChanged();
    if (context.mounted) {
      Navigator.pop(context);

      // Safe Undo SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Item marked as MISSING.'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () async {
              final restoredItem = item.copyWith(
                  status: previousStatus, updatedAt: DateTime.now());
              await itemRepo.saveItem(restoredItem);
              await invRepo.recordEvent(
                InventoryEvent(
                  id: const Uuid().v4(),
                  workspaceId: item.workspaceId,
                  itemId: item.id,
                  type: InventoryEventType.stored,
                  toLocationId: item.locationId,
                  toBinId: item.binId,
                  note: 'Reverted missing status via Undo',
                  occurredAt: DateTime.now(),
                ),
              );
              onStatusChanged();
            },
          ),
        ),
      );
    }
  }

  void _showMoveLocationPicker(BuildContext context, WidgetRef ref) {
    final binRepo = ref.read(binRepositoryProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => FutureBuilder<List<Bin>>(
        future: binRepo.getBinsForWorkspace(item.workspaceId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()));
          }
          final bins = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Reassign Bin / Location',
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
                        onTap: () async {
                          final itemRepo = ref.read(itemRepositoryProvider);
                          final invRepo = ref.read(inventoryRepositoryProvider);
                          final analytics = ref.read(analyticsServiceProvider);
                          final now = DateTime.now();

                          final updated = item.copyWith(
                            status: ItemStatus.stored,
                            locationId: bin.locationId,
                            binId: bin.id,
                            updatedAt: now,
                          );
                          await itemRepo.saveItem(updated);

                          await invRepo.recordEvent(
                            InventoryEvent(
                              id: const Uuid().v4(),
                              workspaceId: item.workspaceId,
                              itemId: item.id,
                              type: InventoryEventType.moved,
                              fromLocationId: item.locationId,
                              fromBinId: item.binId,
                              toLocationId: bin.locationId,
                              toBinId: bin.id,
                              note:
                                  'Moved to Bin ${bin.code} via search relocation',
                              occurredAt: now,
                            ),
                          );

                          analytics.logItemFoundAgain(item.id, bin.id);
                          onStatusChanged();
                          if (ctx.mounted) Navigator.pop(ctx);
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
}
