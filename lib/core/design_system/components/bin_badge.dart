import 'package:flutter/material.dart';
import '../app_radius.dart';

class BinBadge extends StatelessWidget {
  const BinBadge({
    super.key,
    required this.code,
    this.locationName,
  });

  final String code;
  final String? locationName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: AppRadius.borderSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.all_inbox, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            locationName != null ? '$locationName > $code' : code,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
