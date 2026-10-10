import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/di/providers.dart';
import '../../../core/services/onboarding_service.dart';
import '../../../core/widgets/page_header.dart';
import '../../workspace/domain/workspace.dart';

final workspaceDetailProvider = FutureProvider((ref) async {
  final repo = ref.watch(workspaceRepositoryProvider);
  final wsId = ref.watch(currentWorkspaceIdProvider);
  return repo.getWorkspace(wsId);
});

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wsAsync = ref.watch(workspaceDetailProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          const PageHeader('More'),
          wsAsync.when(
            data: (ws) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Card(
                child: ListTile(
                  title: Text(
                    ws?.name ?? 'My Workspace',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(ws?.description ??
                      'Workspace ID: ${ws?.id ?? 'default'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => _showEditWorkspaceModal(
                        context, ref, ws?.name, ws?.description),
                  ),
                ),
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: AppSpacing.md),
          ListTile(
            leading: const Icon(Icons.place_outlined),
            title: const Text('Locations & Storage'),
            subtitle: const Text('Manage warehouses, garages, and racks'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/locations'),
          ),
          for (final item in const [
            ('Import / Export', Icons.import_export),
            ('Sync & backup', Icons.cloud_outlined),
            ('Labels & printing', Icons.print_outlined),
            ('Currency & units', Icons.language),
            ('Account', Icons.person_outline),
          ])
            ListTile(
              leading: Icon(item.$2),
              title: Text(item.$1),
              trailing: const Icon(Icons.chevron_right),
            ),
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: AppButton(
              label: 'Reset Onboarding Flow',
              isSecondary: true,
              onPressed: () async {
                await OnboardingService().resetOnboarding();
                if (context.mounted) {
                  context.go('/onboarding');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditWorkspaceModal(BuildContext context, WidgetRef ref,
      String? currentName, String? currentDesc) {
    final nameController =
        TextEditingController(text: currentName ?? 'My Workspace');
    final descController = TextEditingController(text: currentDesc ?? '');

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
              'Edit Workspace',
              style: Theme.of(ctx)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Workspace Name'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: descController,
              decoration:
                  const InputDecoration(labelText: 'Description / Notes'),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Save Workspace',
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  final wsId = ref.read(currentWorkspaceIdProvider);
                  final repo = ref.read(workspaceRepositoryProvider);

                  final existing = await repo.getWorkspace(wsId);
                  final updated = (existing ??
                          Workspace(
                              id: wsId,
                              name: name,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now()))
                      .copyWith(
                    name: name,
                    description: descController.text.trim().isEmpty
                        ? null
                        : descController.text.trim(),
                    updatedAt: DateTime.now(),
                  );

                  await repo.saveWorkspace(updated);
                  ref.invalidate(workspaceDetailProvider);
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
