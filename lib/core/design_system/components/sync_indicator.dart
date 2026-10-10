import 'package:flutter/material.dart';

class SyncIndicator extends StatelessWidget {
  const SyncIndicator({super.key, required this.isSynced});

  final bool isSynced;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isSynced ? 'Synced' : 'Local / Pending sync',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSynced ? Icons.cloud_done : Icons.cloud_queue,
            size: 16,
            color: isSynced ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            isSynced ? 'Synced' : 'Local',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isSynced ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
