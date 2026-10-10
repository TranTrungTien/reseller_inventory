import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/di/providers.dart';
import '../../../core/domain/value_objects/money.dart';
import '../domain/item.dart';

class EditItemSheet extends ConsumerStatefulWidget {
  const EditItemSheet({super.key, required this.item, required this.onSaved});

  final Item item;
  final VoidCallback onSaved;

  @override
  ConsumerState<EditItemSheet> createState() => _EditItemSheetState();
}

class _EditItemSheetState extends ConsumerState<EditItemSheet> {
  late TextEditingController _titleController;
  late TextEditingController _brandController;
  late TextEditingController _categoryController;
  late TextEditingController _sizeController;
  late TextEditingController _colorController;
  late TextEditingController _conditionController;
  late TextEditingController _costController;
  late TextEditingController _sourceController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _titleController = TextEditingController(text: item.title);
    _brandController = TextEditingController(text: item.brand ?? '');
    _categoryController = TextEditingController(text: item.category ?? '');
    _sizeController = TextEditingController(text: item.size ?? '');
    _colorController = TextEditingController(text: item.color ?? '');
    _conditionController = TextEditingController(text: item.condition ?? '');
    _costController = TextEditingController(
      text: item.cost != null
          ? item.cost!.amountInMajorUnits.toStringAsFixed(2)
          : '',
    );
    _sourceController = TextEditingController(text: item.source ?? '');
    _descController = TextEditingController(text: item.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _sizeController.dispose();
    _colorController.dispose();
    _conditionController.dispose();
    _costController.dispose();
    _sourceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Enrich Item Details',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'e.g. Patagonia Synchilla Fleece'),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _brandController,
                    decoration: const InputDecoration(
                        labelText: 'Brand', hintText: 'Patagonia'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                        labelText: 'Category', hintText: 'Jackets'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _sizeController,
                    decoration:
                        const InputDecoration(labelText: 'Size', hintText: 'L'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: _colorController,
                    decoration: const InputDecoration(
                        labelText: 'Color', hintText: 'Blue'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _conditionController,
                    decoration: const InputDecoration(
                        labelText: 'Condition', hintText: 'Excellent'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: TextField(
                    controller: _costController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Cost (\$)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _sourceController,
              decoration: const InputDecoration(
                  labelText: 'Source / Haul', hintText: 'Goodwill Thrift'),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _descController,
              maxLines: 2,
              decoration:
                  const InputDecoration(labelText: 'Notes & Description'),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Save Item Details',
              onPressed: _saveDetails,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDetails() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty.')),
      );
      return;
    }

    final costText = _costController.text.trim();
    Money? parsedCost;
    if (costText.isNotEmpty) {
      final val = double.tryParse(costText);
      if (val != null) {
        parsedCost = Money.fromMajorUnits(val, widget.item.currency);
      }
    }

    final updatedItem = widget.item.copyWith(
      title: title,
      brand: _brandController.text.trim().isEmpty
          ? null
          : _brandController.text.trim(),
      category: _categoryController.text.trim().isEmpty
          ? null
          : _categoryController.text.trim(),
      size: _sizeController.text.trim().isEmpty
          ? null
          : _sizeController.text.trim(),
      color: _colorController.text.trim().isEmpty
          ? null
          : _colorController.text.trim(),
      condition: _conditionController.text.trim().isEmpty
          ? null
          : _conditionController.text.trim(),
      cost: parsedCost,
      source: _sourceController.text.trim().isEmpty
          ? null
          : _sourceController.text.trim(),
      description: _descController.text.trim().isEmpty
          ? null
          : _descController.text.trim(),
      updatedAt: DateTime.now(),
      revision: widget.item.revision + 1,
    );

    final itemRepo = ref.read(itemRepositoryProvider);
    await itemRepo.saveItem(updatedItem);

    widget.onSaved();
    if (mounted) Navigator.pop(context);
  }
}
