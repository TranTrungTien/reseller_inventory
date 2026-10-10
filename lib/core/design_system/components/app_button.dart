import 'package:flutter/material.dart';
import '../app_radius.dart';
import '../app_spacing.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isFullWidth = false,
    this.isSecondary = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    final button = icon != null
        ? FilledButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: 20),
            label: Text(label),
            style: _style(context),
          )
        : FilledButton(
            onPressed: onPressed,
            style: _style(context),
            child: Text(label),
          );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  ButtonStyle _style(BuildContext context) {
    if (isSecondary) {
      return FilledButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg, vertical: AppSpacing.md),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
      );
    }
    return FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.md),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.borderLg),
    );
  }
}
