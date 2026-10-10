import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/domain/value_objects/money.dart';
import '../../inventory/domain/item.dart';
import '../../inventory/domain/item_photo.dart';
import '../domain/turbo_intake_session.dart';
import '../domain/turbo_intake_service.dart';

class TurboIntakeState {
  const TurboIntakeState({
    this.session,
    this.isCapturing = false,
    this.lastCapturedTitle,
    this.errorMessage,
    this.pendingRecoveryPhoto,
  });

  final TurboIntakeSession? session;
  final bool isCapturing;
  final String? lastCapturedTitle;
  final String? errorMessage;
  final File? pendingRecoveryPhoto;

  bool get isBinLocked => session != null;

  TurboIntakeState copyWith({
    TurboIntakeSession? session,
    bool? isCapturing,
    String? lastCapturedTitle,
    String? errorMessage,
    File? pendingRecoveryPhoto,
    bool clearSession = false,
  }) {
    return TurboIntakeState(
      session: clearSession ? null : (session ?? this.session),
      isCapturing: isCapturing ?? this.isCapturing,
      lastCapturedTitle: lastCapturedTitle ?? this.lastCapturedTitle,
      errorMessage: errorMessage,
      pendingRecoveryPhoto: pendingRecoveryPhoto ?? this.pendingRecoveryPhoto,
    );
  }
}

class TurboIntakeController extends StateNotifier<TurboIntakeState> {
  TurboIntakeController({
    required this.turboIntakeService,
  }) : super(const TurboIntakeState());

  final TurboIntakeService turboIntakeService;

  void lockBin({
    required String workspaceId,
    required String locationId,
    required String binId,
    required String binCode,
    String? locationName,
  }) {
    state = state.copyWith(
      session: TurboIntakeSession(
        id: const Uuid().v4(),
        workspaceId: workspaceId,
        locationId: locationId,
        binId: binId,
        binCode: binCode,
        locationName: locationName,
        startedAt: DateTime.now(),
      ),
    );
  }

  void unlockBin() {
    state = state.copyWith(clearSession: true);
  }

  void setCostShortcut({
    Money? defaultCost,
    Money? totalHaulCost,
    int? haulItemCount,
  }) {
    if (state.session == null) return;
    state = state.copyWith(
      session: state.session!.copyWith(
        defaultCost: defaultCost,
        totalHaulCost: totalHaulCost,
        haulItemCount: haulItemCount,
      ),
    );
  }

  Future<bool> capturePhoto(File photoFile) async {
    if (state.session == null || state.isCapturing) return false;

    state = state.copyWith(isCapturing: true, errorMessage: null);

    try {
      final captureResult = await turboIntakeService.captureItemInBin(
        session: state.session!,
        imageFile: photoFile,
      );

      // Trigger haptic feedback on successful local write
      HapticFeedback.mediumImpact();

      final updatedItems = List<Item>.from(state.session!.itemsAdded)
        ..add(captureResult.item);
      final updatedPhotos = List<ItemPhoto>.from(state.session!.photosAdded)
        ..add(captureResult.photo);

      state = state.copyWith(
        isCapturing: false,
        lastCapturedTitle: captureResult.item.title,
        pendingRecoveryPhoto: null,
        session: state.session!.copyWith(
          itemsAdded: updatedItems,
          photosAdded: updatedPhotos,
        ),
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isCapturing: false,
        errorMessage: 'Capture failed: $e. Photo saved for retry.',
        pendingRecoveryPhoto: photoFile,
      );
      return false;
    }
  }

  Future<bool> retryPendingCapture() async {
    if (state.pendingRecoveryPhoto != null) {
      return capturePhoto(state.pendingRecoveryPhoto!);
    }
    return false;
  }
}
