import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../qr/qr_service.dart';
import '../app_radius.dart';
import '../app_spacing.dart';

class LabelPreview extends StatelessWidget {
  const LabelPreview({
    super.key,
    required this.binId,
    required this.binCode,
    this.locationName,
  });

  final String binId;
  final String binCode;
  final String? locationName;

  @override
  Widget build(BuildContext context) {
    final payload = QrService.encodeBinPayload(binId);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderLg,
        side: const BorderSide(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'BINLY',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                if (locationName != null)
                  Text(
                    locationName!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
              ],
            ),
            const Divider(height: 24),
            Text(
              'BIN $binCode',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            QrImageView(
              data: payload,
              version: QrVersions.auto,
              size: 160.0,
              gapless: false,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              binId,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade500,
                fontFamily: 'Monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
