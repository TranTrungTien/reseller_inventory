import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/bin_badge.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/status_badge.dart';
import '../../../core/di/providers.dart';
import '../../../core/domain/value_objects/enums.dart';
import '../../../core/localization/app_localizations.dart';
import '../../bins/domain/bin.dart';
import '../domain/inventory_event.dart';
import '../domain/item.dart';
import '../domain/item_photo.dart';
import 'cant_find_modal.dart';
import 'edit_item_sheet.dart';

final itemDetailProvider =
    FutureProvider.family<Item?, String>((ref, itemId) async {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.getItem(itemId);
});

final itemPhotosProvider =
    FutureProvider.family<List<ItemPhoto>, String>((ref, itemId) async {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.getPhotosForItem(itemId);
});

final itemHistoryProvider =
    FutureProvider.family<List<InventoryEvent>, String>((ref, itemId) async {
  final repo = ref.watch(inventoryRepositoryProvider);
  return repo.getEventsForItem(itemId);
});

class ItemDetailPage extends ConsumerStatefulWidget {
  const ItemDetailPage({super.key, required this.itemId});

  final String itemId;

  @override
  ConsumerState<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends ConsumerState<ItemDetailPage> {
  @override
  void initState() {
    super.initState();
    // Start duration tracking for search-to-found retrieval loop
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(findTrackerProvider).startFindIntent(widget.itemId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemAsync = ref.watch(itemDetailProvider(widget.itemId));
    final photosAsync = ref.watch(itemPhotosProvider(widget.itemId));
    final historyAsync = ref.watch(itemHistoryProvider(widget.itemId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Details',
            onPressed: () {
              final item = itemAsync.value;
              if (item != null) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => EditItemSheet(
                    item: item,
                    onSaved: () {
                      ref.invalidate(itemDetailProvider(widget.itemId));
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: itemAsync.when(
        data: (item) {
          if (item == null) {
            return const EmptyState(
              title: 'Item Not Found',
              message: 'This item may have been archived or deleted.',
            );
          }

          final isMissing = item.status == ItemStatus.missing;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Photos Carousel
                  photosAsync.when(
                    data: (photos) {
                      if (photos.isEmpty) {
                        return Container(
                          height: 180,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(Icons.photo_library_outlined,
                                size: 48, color: Colors.grey),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 220,
                        child: PageView.builder(
                          itemCount: photos.length,
                          itemBuilder: (context, index) {
                            final photo = photos[index];
                            if (photo.localPath != null &&
                                File(photo.localPath!).existsSync()) {
                              return Image.file(File(photo.localPath!),
                                  fit: BoxFit.cover);
                            }
                            return Container(
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image));
                          },
                        ),
                      );
                    },
                    loading: () => const SizedBox(
                        height: 180,
                        child: Center(child: CircularProgressIndicator())),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

                  // PHYSICAL LOCATION DOMINANT BANNER
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    color: isMissing ? Colors.red.shade900 : Colors.black87,
                    child: Row(
                      children: [
                        Icon(isMissing ? Icons.warning_amber : Icons.place,
                            color: Colors.amber, size: 28),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isMissing ? 'ITEM STATUS' : 'PHYSICAL LOCATION',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isMissing
                                    ? 'MISSING / CANNOT FIND'
                                    : (item.binId != null
                                        ? 'BIN ${item.binId}'
                                        : 'NO BIN ASSIGNED'),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        StatusBadge(status: item.status),
                      ],
                    ),
                  ),

                  // PRIMARY PHYSICAL ACTIONS BAR
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        if (isMissing)
                          AppButton(
                            label: 'FOUND AGAIN!',
                            icon: Icons.check_circle_outline,
                            onPressed: () => _handleFoundAgain(context, item),
                          )
                        else ...[
                          AppButton(
                            label: 'FOUND IT',
                            icon: Icons.check_circle_outline,
                            onPressed: () => _handleFoundIt(context, item),
                          ),
                          AppButton(
                            label: 'MOVE',
                            icon: Icons.swap_horiz,
                            isSecondary: true,
                            onPressed: () =>
                                _handleMoveItemModal(context, item),
                          ),
                          AppButton(
                            label: 'MARK SOLD',
                            icon: Icons.attach_money,
                            isSecondary: true,
                            onPressed: () => _handleMarkSold(context, item),
                          ),
                          AppButton(
                            label: "CAN'T FIND",
                            icon: Icons.search_off,
                            isSecondary: true,
                            onPressed: () => _handleCantFind(
                                context, item, historyAsync.value ?? []),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // TITLE & SKU CARD
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'SKU: ${item.sku}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            if (item.cost != null) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Cost: ${item.cost!.format('en_US')}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // METADATA CARD
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Metadata',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Divider(height: 20),
                            _buildMetaRow('Brand', item.brand ?? '—'),
                            _buildMetaRow('Category', item.category ?? '—'),
                            _buildMetaRow('Size', item.size ?? '—'),
                            _buildMetaRow('Color', item.color ?? '—'),
                            _buildMetaRow('Condition', item.condition ?? '—'),
                            _buildMetaRow('Source', item.source ?? '—'),
                            if (item.description != null)
                              _buildMetaRow('Notes', item.description!),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // INVENTORY HISTORY TIMELINE
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Physical History',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Divider(height: 20),
                            historyAsync.when(
                              data: (events) {
                                if (events.isEmpty) {
                                  return const Text(
                                      'No history events recorded.');
                                }
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: events.length,
                                  separatorBuilder: (_, __) =>
                                      const Divider(height: 16),
                                  itemBuilder: (context, index) {
                                    final evt = events[index];
                                    return Row(
                                      children: [
                                        const Icon(Icons.history,
                                            size: 18, color: Colors.grey),
                                        const SizedBox(width: AppSpacing.md),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                evt.type.name.toUpperCase(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                              if (evt.note != null)
                                                Text(evt.note!,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .formatDateTime(evt.occurredAt),
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              loading: () => const CircularProgressIndicator(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _handleFoundIt(BuildContext context, Item item) async {
    final invRepo = ref.read(inventoryRepositoryProvider);
    final findTracker = ref.read(findTrackerProvider);
    final analytics = ref.read(analyticsServiceProvider);
    final now = DateTime.now();

    final elapsedDuration = findTracker.completeFindIntent(item.id);

    await invRepo.recordEvent(
      InventoryEvent(
        id: const Uuid().v4(),
        workspaceId: item.workspaceId,
        itemId: item.id,
        type: InventoryEventType.found,
        toLocationId: item.locationId,
        toBinId: item.binId,
        note: 'Confirmed physical presence in Bin ${item.binId ?? 'N/A'}',
        occurredAt: now,
      ),
    );

    analytics.logItemFound(item.id, item.binId, elapsedDuration);

    ref.invalidate(itemHistoryProvider(widget.itemId));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Item presence confirmed! Search duration: ${elapsedDuration.inSeconds}s')),
      );
    }
  }

  Future<void> _handleFoundAgain(BuildContext context, Item item) async {
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
                  'Found Again! Assign Storage Bin',
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

                          final restored = item.copyWith(
                            status: ItemStatus.stored,
                            locationId: bin.locationId,
                            binId: bin.id,
                            updatedAt: now,
                          );
                          await itemRepo.saveItem(restored);

                          await invRepo.recordEvent(
                            InventoryEvent(
                              id: const Uuid().v4(),
                              workspaceId: item.workspaceId,
                              itemId: item.id,
                              type: InventoryEventType.found,
                              toLocationId: bin.locationId,
                              toBinId: bin.id,
                              note:
                                  'Found again after being missing! Stowed in Bin ${bin.code}',
                              occurredAt: now,
                            ),
                          );

                          analytics.logItemFoundAgain(item.id, bin.id);

                          ref.invalidate(itemDetailProvider(widget.itemId));
                          ref.invalidate(itemHistoryProvider(widget.itemId));
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

  void _handleCantFind(
      BuildContext context, Item item, List<InventoryEvent> history) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CantFindModal(
        item: item,
        historyEvents: history,
        onStatusChanged: () {
          ref.invalidate(itemDetailProvider(widget.itemId));
          ref.invalidate(itemHistoryProvider(widget.itemId));
        },
      ),
    );
  }

  Future<void> _handleMarkSold(BuildContext context, Item item) async {
    final itemRepo = ref.read(itemRepositoryProvider);
    final invRepo = ref.read(inventoryRepositoryProvider);
    final now = DateTime.now();

    final updated = item.copyWith(status: ItemStatus.sold, updatedAt: now);
    await itemRepo.saveItem(updated);

    await invRepo.recordEvent(
      InventoryEvent(
        id: const Uuid().v4(),
        workspaceId: item.workspaceId,
        itemId: item.id,
        type: InventoryEventType.sold,
        fromLocationId: item.locationId,
        fromBinId: item.binId,
        note: 'Marked as Sold',
        occurredAt: now,
      ),
    );

    ref.invalidate(itemDetailProvider(widget.itemId));
    ref.invalidate(itemHistoryProvider(widget.itemId));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item marked as SOLD!')),
      );
    }
  }

  void _handleMoveItemModal(BuildContext context, Item item) {
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
                  'Move Item to New Bin',
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
                      final isCurrent = bin.id == item.binId;
                      return ListTile(
                        leading: const Icon(Icons.all_inbox),
                        title: Text('Bin ${bin.code}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(bin.description ??
                            'Location ID: ${bin.locationId}'),
                        trailing:
                            isCurrent ? const BinBadge(code: 'CURRENT') : null,
                        onTap: isCurrent
                            ? null
                            : () async {
                                final itemRepo =
                                    ref.read(itemRepositoryProvider);
                                final invRepo =
                                    ref.read(inventoryRepositoryProvider);
                                final now = DateTime.now();

                                await itemRepo.updateItemLocation(
                                    item.id, bin.locationId, bin.id);

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
                                    note: 'Moved to Bin ${bin.code}',
                                    occurredAt: now,
                                  ),
                                );

                                ref.invalidate(itemDetailProvider(item.id));
                                ref.invalidate(itemHistoryProvider(item.id));
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
