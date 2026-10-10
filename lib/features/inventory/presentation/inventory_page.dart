import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_search_field.dart';
import '../../../core/design_system/components/bin_badge.dart';
import '../../../core/design_system/components/empty_state.dart';
import '../../../core/design_system/components/status_badge.dart';
import '../../../core/di/providers.dart';
import '../../../core/domain/value_objects/enums.dart';
import '../../../core/widgets/page_header.dart';
import '../domain/item.dart';

final inventorySearchQueryProvider = StateProvider<String>((ref) => '');
final inventoryFilterProvider = StateProvider<String>((ref) => 'All');

final inventoryItemsStreamProvider = FutureProvider<List<Item>>((ref) async {
  final query = ref.watch(inventorySearchQueryProvider);
  final filter = ref.watch(inventoryFilterProvider);
  final repo = ref.watch(itemRepositoryProvider);
  final workspaceId = ref.watch(currentWorkspaceIdProvider);

  ItemStatus? statusFilter;
  bool needsDetails = false;

  if (filter == 'Needs Details') {
    needsDetails = true;
  } else if (filter != 'All') {
    statusFilter = ItemStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == filter.toLowerCase(),
      orElse: () => ItemStatus.stored,
    );
  }

  return repo.searchItems(
    workspaceId,
    query,
    statusFilter: statusFilter,
    needsDetailsOnly: needsDetails,
  );
});

class InventoryPage extends ConsumerWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(inventoryItemsStreamProvider);
    final activeFilter = ref.watch(inventoryFilterProvider);

    final filterOptions = [
      'All',
      'Stored',
      'Listed',
      'Sold',
      'Missing',
      'Needs Details',
      'Archived'
    ];

    return SafeArea(
      child: Column(
        children: [
          const PageHeader(
            'Inventory',
            subtitle: 'Search title, SKU, brand, or bin',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: AppSearchField(
              hintText: 'Nike red XL, B17, SKU...',
              onChanged: (value) =>
                  ref.read(inventorySearchQueryProvider.notifier).state = value,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Filter Chips Horizontal Bar
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              scrollDirection: Axis.horizontal,
              itemCount: filterOptions.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, index) {
                final option = filterOptions[index];
                final isSelected = activeFilter == option;
                return ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(inventoryFilterProvider.notifier).state = option;
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Expanded(
            child: itemsAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    title: 'No matching items',
                    message: activeFilter == 'Needs Details'
                        ? 'All items in your store have complete metadata!'
                        : 'Try searching for another term or clear filter.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl, vertical: AppSpacing.sm),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.borderLg),
                      child: ListTile(
                        onTap: () => context.push('/items/${item.id}'),
                        contentPadding: const EdgeInsets.all(AppSpacing.md),
                        leading: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: AppRadius.borderMd,
                          ),
                          child: const Icon(Icons.inventory_2_outlined,
                              color: Colors.black87),
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                if (item.brand != null || item.size != null)
                                  Text(
                                    '${item.brand ?? ''} ${item.size != null ? '· ${item.size}' : ''}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w600),
                                  ),
                                const Spacer(),
                                Text(
                                  'SKU: ${item.sku}',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // PHYSICAL LOCATION DOMINATED VISUAL ROW
                            Row(
                              children: [
                                if (item.binId != null)
                                  BinBadge(code: item.binId!),
                                const Spacer(),
                                StatusBadge(status: item.status),
                              ],
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
}
