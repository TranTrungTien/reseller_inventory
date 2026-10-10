import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/app_search_field.dart';
import '../../../core/design_system/components/sync_indicator.dart';
import '../../../core/di/providers.dart';
import '../../../core/domain/value_objects/enums.dart';
import '../../../core/widgets/page_header.dart';
import '../../pick/presentation/pick_list_page.dart';

final homeMetricsProvider = FutureProvider<Map<String, int>>((ref) async {
  final workspaceId = ref.watch(currentWorkspaceIdProvider);
  final itemRepo = ref.watch(itemRepositoryProvider);
  final binRepo = ref.watch(binRepositoryProvider);

  final items = await itemRepo.getItemsForWorkspace(workspaceId);
  final bins = await binRepo.getBinsForWorkspace(workspaceId);
  final readyToPick = await itemRepo.getReadyToPickItems(workspaceId);
  final needsDetails =
      await itemRepo.searchItems(workspaceId, '', needsDetailsOnly: true);

  return {
    'totalItems': items.length,
    'readyToPick': readyToPick.length,
    'needsAttention': needsDetails.length +
        items.where((i) => i.status == ItemStatus.missing).length,
    'binsCount': bins.length,
  };
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readyToPickAsync = ref.watch(readyToPickProvider);
    final metricsAsync = ref.watch(homeMetricsProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: PageHeader(
                  'Find what sold. Fast.',
                  subtitle: 'Physical inventory, without the admin.',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24, right: 20),
                child: SyncIndicator(isSynced: true),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: AppSearchField(
              readOnly: true,
              onTap: () => context.go('/inventory'),
              hintText: 'Find an item, SKU or bin',
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const _Actions(),

          const SizedBox(height: AppSpacing.lg),

          // SUMMARY METRIC CARDS GRID
          metricsAsync.when(
            data: (metrics) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _MetricCard(
                    title: 'Total Items',
                    value: '${metrics['totalItems']}',
                    icon: Icons.inventory_2_outlined,
                    color: Colors.blue.shade700,
                    onTap: () => context.go('/inventory'),
                  ),
                  _MetricCard(
                    title: 'Ready to Pick',
                    value: '${metrics['readyToPick']}',
                    icon: Icons.shopping_bag_outlined,
                    color: Colors.orange.shade800,
                    onTap: () => context.push('/pick'),
                  ),
                  _MetricCard(
                    title: 'Needs Attention',
                    value: '${metrics['needsAttention']}',
                    icon: Icons.error_outline,
                    color: Colors.red.shade700,
                    onTap: () => context.go('/inventory'),
                  ),
                  _MetricCard(
                    title: 'Active Bins',
                    value: '${metrics['binsCount']}',
                    icon: Icons.all_inbox_outlined,
                    color: Colors.green.shade800,
                    onTap: () => context.go('/bins'),
                  ),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // READY TO PICK CARD BANNER
          readyToPickAsync.when(
            data: (items) {
              if (items.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, 0),
                child: Card(
                  color: Colors.amber.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.amber.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_bag,
                            color: Colors.orange, size: 32),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${items.length} Sold Items Ready to Pick',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(height: 2),
                              const Text('Sorted by physical location path.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54)),
                            ],
                          ),
                        ),
                        AppButton(
                          label: 'Pick Now',
                          onPressed: () => context.push('/pick'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          const SizedBox(height: AppSpacing.xxl),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              'TODAY',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: Colors.black54),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Physical Inventory Hub',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: AppSpacing.xs),
                          Text(
                              'Start by creating a bin, or use Turbo Intake for fast intake.'),
                        ],
                      ),
                    ),
                    AppButton(
                      label: 'Create bin',
                      onPressed: () => context.go('/bins'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 2.1,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _ActionTile(
            icon: Icons.add_a_photo_outlined,
            label: 'Turbo intake',
            onTap: () => context.go('/scan'),
          ),
          _ActionTile(
            icon: Icons.qr_code_2,
            label: 'Scan bin',
            onTap: () => context.go('/scan'),
          ),
          _ActionTile(
            icon: Icons.add_box_outlined,
            label: 'Create bin',
            onTap: () => context.go('/bins'),
          ),
          _ActionTile(
            icon: Icons.shopping_bag_outlined,
            label: 'Pick orders',
            onTap: () => context.push('/pick'),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
