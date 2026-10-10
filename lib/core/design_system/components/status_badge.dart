import 'package:flutter/material.dart';
import '../../domain/value_objects/enums.dart';
import '../app_colors.dart';
import '../app_radius.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ItemStatus status;

  @override
  Widget build(BuildContext context) {
    final colorPair = _getColorPair(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorPair.$1,
        borderRadius: AppRadius.borderSm,
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: colorPair.$2,
        ),
      ),
    );
  }

  (Color, Color) _getColorPair(ItemStatus status) {
    switch (status) {
      case ItemStatus.stored:
        return (AppColors.statusStored, AppColors.statusStoredText);
      case ItemStatus.listed:
        return (AppColors.statusListed, AppColors.statusListedText);
      case ItemStatus.sold:
      case ItemStatus.picked:
        return (AppColors.statusSold, AppColors.statusSoldText);
      case ItemStatus.missing:
        return (AppColors.statusMissing, AppColors.statusMissingText);
      default:
        return (Colors.grey.shade200, Colors.grey.shade800);
    }
  }
}
