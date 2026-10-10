import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../permissions/permission_service.dart';
import '../qr/qr_service.dart';
import '../../features/bins/domain/bin_repository.dart';

class ScannerState {
  const ScannerState({
    this.permissionStatus = PermissionStatus.notRequested,
    this.isScanning = false,
    this.isPaused = false,
    this.isTorchOn = false,
    this.isProcessing = false,
    this.lastScannedCode,
    this.lastScannedAt,
    this.lastResolution,
    this.errorMessage,
  });

  final PermissionStatus permissionStatus;
  final bool isScanning;
  final bool isPaused;
  final bool isTorchOn;
  final bool isProcessing;
  final String? lastScannedCode;
  final DateTime? lastScannedAt;
  final QrResolution? lastResolution;
  final String? errorMessage;

  ScannerState copyWith({
    PermissionStatus? permissionStatus,
    bool? isScanning,
    bool? isPaused,
    bool? isTorchOn,
    bool? isProcessing,
    String? lastScannedCode,
    DateTime? lastScannedAt,
    QrResolution? lastResolution,
    String? errorMessage,
  }) {
    return ScannerState(
      permissionStatus: permissionStatus ?? this.permissionStatus,
      isScanning: isScanning ?? this.isScanning,
      isPaused: isPaused ?? this.isPaused,
      isTorchOn: isTorchOn ?? this.isTorchOn,
      isProcessing: isProcessing ?? this.isProcessing,
      lastScannedCode: lastScannedCode ?? this.lastScannedCode,
      lastScannedAt: lastScannedAt ?? this.lastScannedAt,
      lastResolution: lastResolution ?? this.lastResolution,
      errorMessage: errorMessage,
    );
  }
}

class ScannerController extends StateNotifier<ScannerState> {
  ScannerController({
    required this.permissionService,
    this.debounceDuration = const Duration(seconds: 2),
  }) : super(const ScannerState()) {
    checkPermission();
  }

  final PermissionService permissionService;
  final Duration debounceDuration;

  Future<void> checkPermission() async {
    final status =
        await permissionService.checkPermission(AppPermission.camera);
    state = state.copyWith(permissionStatus: status);
  }

  Future<void> requestPermission() async {
    final status =
        await permissionService.requestPermission(AppPermission.camera);
    state = state.copyWith(permissionStatus: status);
  }

  Future<void> openSettings() async {
    await permissionService.openAppSettings();
  }

  void pause() {
    state = state.copyWith(isPaused: true);
  }

  void resume() {
    state = state.copyWith(isPaused: false);
  }

  void toggleTorch() {
    state = state.copyWith(isTorchOn: !state.isTorchOn);
  }

  Future<QrResolution?> handleScannedCode(
      String rawCode, BinRepository binRepo) async {
    final trimmed = rawCode.trim();
    if (trimmed.isEmpty || state.isPaused || state.isProcessing) {
      return null;
    }

    final now = DateTime.now();

    // Debounce duplicate scans
    if (state.lastScannedCode == trimmed && state.lastScannedAt != null) {
      final elapsed = now.difference(state.lastScannedAt!);
      if (elapsed < debounceDuration) {
        return null; // Ignore duplicate scan within debounce window
      }
    }

    state = state.copyWith(
      isProcessing: true,
      lastScannedCode: trimmed,
      lastScannedAt: now,
    );

    final resolution = await QrService.resolveBinQr(trimmed, binRepo);

    state = state.copyWith(
      isProcessing: false,
      lastResolution: resolution,
    );

    return resolution;
  }
}
