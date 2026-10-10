import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/label_preview.dart';
import '../../../core/design_system/components/status_badge.dart';
import '../../../core/di/providers.dart';
import '../../inventory/domain/item.dart';
import '../domain/bin.dart';

final binDetailProvider =
    FutureProvider.family<Bin?, String>((ref, binId) async {
  final repo = ref.watch(binRepositoryProvider);
  return repo.getBin(binId);
});

final binItemsProvider =
    FutureProvider.family<List<Item>, String>((ref, binId) async {
  final repo = ref.watch(itemRepositoryProvider);
  return repo.getItemsForBin(binId);
});

final binItemCountProvider =
    FutureProvider.family<int, String>((ref, binId) async {
  final repo = ref.watch(binRepositoryProvider);
  return repo.getItemCountForBin(binId);
});

class BinDetailPage extends ConsumerWidget {
  const BinDetailPage({super.key, required this.binId});

  final String binId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final binAsync = ref.watch(binDetailProvider(binId));
    final itemsAsync = ref.watch(binItemsProvider(binId));
    final countAsync = ref.watch(binItemCountProvider(binId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bin Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Label Preview',
            onPressed: () => _showLabelPreviewModal(context, ref),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                _showEditBinModal(context, ref);
              } else if (value == 'archive') {
                _archiveBin(context, ref);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit Bin')),
              PopupMenuItem(value: 'archive', child: Text('Archive Bin')),
            ],
          ),
        ],
      ),
      body: binAsync.when(
        data: (bin) {
          if (bin == null) {
            return const EmptyState(
              title: 'Bin Not Found',
              message: 'This bin may have been deleted or does not exist.',
            );
          }
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BIN ${bin.code}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                          if (bin.isArchived)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'ARCHIVED',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        bin.description ?? 'Location ID: ${bin.locationId}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Chip(
                            avatar: const Icon(Icons.inventory_2, size: 16),
                            label: Text(
                              countAsync.when(
                                data: (count) => '$count Items in Bin',
                                loading: () => '...',
                                error: (_, __) => '0 Items',
                              ),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          AppButton(
                            label: 'Print Label',
                            icon: Icons.print,
                            isSecondary: true,
                            onPressed: () =>
                                _showLabelPreviewModal(context, ref),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.xl,
                      AppSpacing.lg, AppSpacing.xl, AppSpacing.xs),
                  child: Text(
                    'ITEMS IN THIS BIN',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: itemsAsync.when(
                    data: (items) {
                      if (items.isEmpty) {
                        return EmptyState(
                          title: 'Bin is empty',
                          message:
                              'No items currently stowed in Bin ${bin.code}.',
                          action: AppButton(
                            label: 'Stow Item in Bin',
                            icon: Icons.add,
                            onPressed: () => context.go('/scan'),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        itemCount: items.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            child: ListTile(
                              title: Text(item.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text('SKU: ${item.sku}'),
                              trailing: StatusBadge(status: item.status),
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  void _showLabelPreviewModal(BuildContext context, WidgetRef ref) {
    final bin = ref.read(binDetailProvider(binId)).value;
    if (bin == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Label Preview',
              style: Theme.of(ctx)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            LabelPreview(
              binId: bin.id,
              binCode: bin.code,
              locationName: bin.description ?? 'Location',
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Close Preview',
              isFullWidth: true,
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditBinModal(BuildContext context, WidgetRef ref) {
    final bin = ref.read(binDetailProvider(binId)).value;
    if (bin == null) return;

    final codeController = TextEditingController(text: bin.code);
    final descController = TextEditingController(text: bin.description ?? '');

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
              'Edit Bin ${bin.code}',
              style: Theme.of(ctx)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: codeController,
              decoration: const InputDecoration(
                  labelText: 'Bin Code', hintText: 'e.g. A01'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  labelText: 'Description / Notes', hintText: 'Top shelf'),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Save Changes',
              onPressed: () async {
                final newCode = codeController.text.trim().toUpperCase();
                if (newCode.isNotEmpty) {
                  final binRepo = ref.read(binRepositoryProvider);

                  // Check duplicate code
                  final isAvailable = await binRepo.isBinCodeAvailable(
                    bin.locationId,
                    newCode,
                    excludeBinId: bin.id,
                  );

                  if (!isAvailable) {
                    if (ctx.mounted) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Bin code "$newCode" already exists in this location.')),
                      );
                    }
                    return;
                  }

                  await binRepo.saveBin(
                    bin.copyWith(
                      code: newCode,
                      description: descController.text.trim().isEmpty
                          ? null
                          : descController.text.trim(),
                      updatedAt: DateTime.now(),
                    ),
                  );

                  ref.invalidate(binDetailProvider(binId));
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _archiveBin(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Archive Bin?'),
        content: const Text(
            'Archiving this bin hides it from active listings. Contained items will retain their location history.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Archive')),
        ],
      ),
    );

    if (confirm == true) {
      final repo = ref.read(binRepositoryProvider);
      await repo.archiveBin(binId);
      ref.invalidate(binDetailProvider(binId));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bin archived successfully.')),
        );
      }
    }
  }
}
