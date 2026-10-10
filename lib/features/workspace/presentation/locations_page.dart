import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/di/providers.dart';
import '../domain/location.dart';

final locationsListProvider = FutureProvider<List<Location>>((ref) async {
  final repo = ref.watch(locationRepositoryProvider);
  final workspaceId = ref.watch(currentWorkspaceIdProvider);
  return repo.getLocationsForWorkspace(workspaceId);
});

class LocationsPage extends ConsumerWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: AppButton(
                label: 'Add Location',
                icon: Icons.add_location_alt,
                onPressed: () => _showAddLocationModal(context, ref),
              ),
            ),
            Expanded(
              child: locationsAsync.when(
                data: (locations) {
                  if (locations.isEmpty) {
                    return const EmptyState(
                      title: 'No locations yet',
                      message:
                          'Add a location like Garage, Storage Unit, or Basement.',
                    );
                  }
                  return ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    itemCount: locations.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      final loc = locations[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.place_outlined),
                          title: Text(loc.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle:
                              Text(loc.description ?? 'Location ID: ${loc.id}'),
                          trailing: PopupMenuButton<String>(
                            onSelected: (val) {
                              if (val == 'edit') {
                                _showEditLocationModal(context, ref, loc);
                              } else if (val == 'archive') {
                                _archiveLocation(context, ref, loc.id);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                  value: 'edit', child: Text('Edit Location')),
                              PopupMenuItem(
                                  value: 'archive',
                                  child: Text('Archive Location')),
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
      ),
    );
  }

  void _showAddLocationModal(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

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
              'Add Location',
              style: Theme.of(ctx)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: 'Location Name', hintText: 'e.g. Storage Unit 4B'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  labelText: 'Description / Address', hintText: '123 Main St'),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Save Location',
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  final workspaceId = ref.read(currentWorkspaceIdProvider);
                  final repo = ref.read(locationRepositoryProvider);

                  await repo.saveLocation(
                    Location(
                      id: const Uuid().v4(),
                      workspaceId: workspaceId,
                      name: name,
                      description: descController.text.trim().isEmpty
                          ? null
                          : descController.text.trim(),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  );

                  ref.invalidate(locationsListProvider);
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditLocationModal(
      BuildContext context, WidgetRef ref, Location location) {
    final nameController = TextEditingController(text: location.name);
    final descController =
        TextEditingController(text: location.description ?? '');

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
              'Edit Location',
              style: Theme.of(ctx)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Location Name'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: descController,
              decoration:
                  const InputDecoration(labelText: 'Description / Notes'),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Save Changes',
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  final repo = ref.read(locationRepositoryProvider);

                  await repo.saveLocation(
                    location.copyWith(
                      name: name,
                      description: descController.text.trim().isEmpty
                          ? null
                          : descController.text.trim(),
                      updatedAt: DateTime.now(),
                    ),
                  );

                  ref.invalidate(locationsListProvider);
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _archiveLocation(
      BuildContext context, WidgetRef ref, String locationId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Archive Location?'),
        content: const Text(
            'Archiving this location will hide it from active selections.'),
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
      final repo = ref.read(locationRepositoryProvider);
      await repo.archiveLocation(locationId);
      ref.invalidate(locationsListProvider);
    }
  }
}
