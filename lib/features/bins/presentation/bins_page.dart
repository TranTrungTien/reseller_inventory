import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/app_search_field.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/bin_badge.dart';
import '../../../core/design_system/components/label_preview.dart';
import '../../../core/di/providers.dart';
import '../../../core/widgets/page_header.dart';
import '../domain/bin.dart';
import '../../workspace/domain/location.dart';

final binSearchQueryProvider = StateProvider<String>((ref) => '');

final binsListProvider = FutureProvider<List<Bin>>((ref) async {
  final query = ref.watch(binSearchQueryProvider);
  final repo = ref.watch(binRepositoryProvider);
  final workspaceId = ref.watch(currentWorkspaceIdProvider);
  return repo.searchBins(workspaceId, query);
});

class BinsPage extends ConsumerWidget {
  const BinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final binsAsync = ref.watch(binsListProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PageHeader(
            'Bins',
            subtitle: 'Your physical storage map',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Row(
              children: [
                Expanded(
                  child: AppSearchField(
                    hintText: 'Search bin code or notes...',
                    onChanged: (value) =>
                        ref.read(binSearchQueryProvider.notifier).state = value,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(
                  onPressed: () => _showCreateBinDialog(context, ref),
                  icon: const Icon(Icons.add),
                  tooltip: 'Create Bin',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: binsAsync.when(
              data: (bins) {
                if (bins.isEmpty) {
                  return EmptyState(
                    title: 'No bins found',
                    message: 'Try A01 for your first bin.',
                    action: AppButton(
                      label: 'Create First Bin',
                      icon: Icons.add,
                      onPressed: () => _showCreateBinDialog(context, ref),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  itemCount: bins.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final bin = bins[index];
                    return Card(
                      child: ListTile(
                        onTap: () => context.push('/bins/${bin.id}'),
                        leading: const Icon(Icons.all_inbox_outlined),
                        title: Text('Bin ${bin.code}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(bin.description ??
                            'Location ID: ${bin.locationId}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BinBadge(code: bin.code),
                            IconButton(
                              icon: const Icon(Icons.qr_code, size: 20),
                              onPressed: () =>
                                  _showLabelPreviewModal(context, bin),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  void _showLabelPreviewModal(BuildContext context, Bin bin) {
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

  void _showCreateBinDialog(BuildContext context, WidgetRef ref) {
    final codeController = TextEditingController();
    final locationController = TextEditingController(text: 'Garage');

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
              'Create bin',
              style: Theme.of(ctx)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: codeController,
              decoration:
                  const InputDecoration(labelText: 'Bin code', hintText: 'A01'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                  labelText: 'Location name', hintText: 'Garage'),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Create & generate QR',
              onPressed: () async {
                final code = codeController.text.trim().toUpperCase();
                final locName = locationController.text.trim().isEmpty
                    ? 'Garage'
                    : locationController.text.trim();

                if (code.isNotEmpty) {
                  final workspaceId = ref.read(currentWorkspaceIdProvider);
                  final binRepo = ref.read(binRepositoryProvider);
                  final locationRepo = ref.read(locationRepositoryProvider);

                  // 1. Get or create location
                  final existingLocations =
                      await locationRepo.getLocationsForWorkspace(workspaceId);
                  Location? targetLoc =
                      existingLocations.cast<Location?>().firstWhere(
                            (l) =>
                                l?.name.toLowerCase() == locName.toLowerCase(),
                            orElse: () => null,
                          );

                  if (targetLoc == null) {
                    targetLoc = Location(
                      id: const Uuid().v4(),
                      workspaceId: workspaceId,
                      name: locName,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    await locationRepo.saveLocation(targetLoc);
                  }

                  // 2. Validate duplicate bin code
                  final isAvailable =
                      await binRepo.isBinCodeAvailable(targetLoc.id, code);
                  if (!isAvailable) {
                    if (ctx.mounted) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Bin code "$code" already exists in location "${targetLoc.name}".')),
                      );
                    }
                    return;
                  }

                  // 3. Create Bin
                  await binRepo.saveBin(
                    Bin(
                      id: const Uuid().v4(),
                      workspaceId: workspaceId,
                      locationId: targetLoc.id,
                      code: code,
                      description: 'Location: ${targetLoc.name}',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  );

                  ref.invalidate(binsListProvider);
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
