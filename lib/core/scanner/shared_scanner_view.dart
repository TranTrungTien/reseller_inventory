import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../design_system/app_radius.dart';
import '../design_system/app_spacing.dart';
import '../design_system/components/app_button.dart';
import '../permissions/permission_service.dart';
import 'scanner_controller.dart';

class SharedScannerView extends StatefulWidget {
  const SharedScannerView({
    super.key,
    required this.state,
    required this.controller,
    required this.onDetect,
    this.overlayTitle = 'Scan Bin QR',
  });

  final ScannerState state;
  final ScannerController controller;
  final ValueChanged<BarcodeCapture> onDetect;
  final String overlayTitle;

  @override
  State<SharedScannerView> createState() => _SharedScannerViewState();
}

class _SharedScannerViewState extends State<SharedScannerView> {
  late MobileScannerController _mobileScannerController;

  @override
  void initState() {
    super.initState();
    _mobileScannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  void dispose() {
    _mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state.permissionStatus == PermissionStatus.denied ||
        widget.state.permissionStatus == PermissionStatus.permanentlyDenied) {
      return _buildPermissionDeniedView(context);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: AppRadius.borderXl,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _mobileScannerController,
            onDetect: (capture) {
              if (!widget.state.isPaused && !widget.state.isProcessing) {
                widget.onDetect(capture);
              }
            },
            errorBuilder: (context, error) {
              return _buildErrorView(context, error.toString());
            },
          ),
          // Viewfinder Overlay
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      widget.state.isProcessing ? Colors.orange : Colors.white,
                  width: 3,
                ),
                borderRadius: AppRadius.borderLg,
              ),
            ),
          ),
          // Controls Overlay
          Positioned(
            top: AppSpacing.lg,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: AppRadius.borderSm,
                  ),
                  child: Text(
                    widget.overlayTitle,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    widget.state.isTorchOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _mobileScannerController.toggleTorch();
                    widget.controller.toggleTorch();
                  },
                ),
              ],
            ),
          ),
          if (widget.state.isPaused)
            Container(
              color: Colors.black87,
              child: const Center(
                child: Text(
                  'Scanner Paused',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedView(BuildContext context) {
    final isPermanent =
        widget.state.permissionStatus == PermissionStatus.permanentlyDenied;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: AppRadius.borderXl,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.camera_alt, color: Colors.white70, size: 56),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Camera Access Required',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              isPermanent
                  ? 'Camera permission is permanently denied. Please enable it in system settings.'
                  : 'Grant camera access to scan bin QR codes and capture item photos.',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: isPermanent ? 'Open Settings' : 'Grant Camera Access',
              onPressed: () {
                if (isPermanent) {
                  widget.controller.openSettings();
                } else {
                  widget.controller.requestPermission();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.videocam_off, color: Colors.amber, size: 48),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Camera Unavailable (Emulator Mode)',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Hardware camera service issue detected on emulator. You can simulate a QR scan manually below.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Simulate Scan',
              icon: Icons.keyboard,
              isSecondary: true,
              onPressed: () => _showManualCodeDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showManualCodeDialog(BuildContext context) {
    final controller = TextEditingController(text: 'A01');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Simulate Barcode / QR Scan'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Bin Code / QR String',
            hintText: 'e.g. A01 or BIN:GARAGE:A01',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final val = controller.text.trim();
              if (val.isNotEmpty) {
                widget.onDetect(
                  BarcodeCapture(
                    barcodes: [Barcode(rawValue: val)],
                  ),
                );
              }
              Navigator.pop(ctx);
            },
            child: const Text('Submit Scan'),
          ),
        ],
      ),
    );
  }
}
