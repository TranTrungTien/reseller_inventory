import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/bin_badge.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/di/providers.dart';
import '../../inventory/domain/item.dart';

final readyToPickProvider = FutureProvider<List<Item>>((ref) async {
  final repo = ref.watch(itemRepositoryProvider);
  final workspaceId = ref.watch(currentWorkspaceIdProvider);
  return repo.getReadyToPickItems(workspaceId);
});

class PickListPage extends ConsumerWidget {
  const PickListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readyAsync = ref.watch(readyToPickProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ready to Pick'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            readyAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Expanded(
                    child: EmptyState(
                      title: 'All Picked!',
                      message: 'No sold items currently waiting to be picked.',
                      icon: Icons.check_circle_outline,
                    ),
                  );
                }

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        color: Colors.amber.shade100,
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_bag,
                                color: Colors.orange),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              '${items.length} Sold Items Ready for Picking',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: AppButton(
                          label: 'START PICK SESSION',
                          icon: Icons.qr_code_scanner,
                          isFullWidth: true,
                          onPressed: () => context.push('/pick/session'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl),
                        child: Text(
                          'OPTIMIZED PICK PATH (LOCATION > BIN)',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xl,
                              vertical: AppSpacing.sm),
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: AppSpacing.sm),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Card(
                              child: ListTile(
                                onTap: () => context.push('/items/${item.id}'),
                                title: Text(item.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text('SKU: ${item.sku}'),
                                trailing: BinBadge(code: item.binId ?? 'A01'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ],
        ),
      ),
    );
  }
}
