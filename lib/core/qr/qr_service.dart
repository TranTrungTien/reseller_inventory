import '../../features/bins/domain/bin.dart';
import '../../features/bins/domain/bin_repository.dart';

enum QrResolutionStatus {
  valid,
  invalidFormat,
  notFound,
  archived,
}

class QrParseResult {
  const QrParseResult({
    required this.isValid,
    this.entityType,
    this.entityId,
  });

  final bool isValid;
  final String? entityType;
  final String? entityId;
}

class QrResolution {
  const QrResolution({
    required this.status,
    this.bin,
    this.errorMessage,
  });

  final QrResolutionStatus status;
  final Bin? bin;
  final String? errorMessage;
}

class QrService {
  static const String prefix = 'binly:bin:';

  static String encodeBinPayload(String binId) {
    return '$prefix$binId';
  }

  static QrParseResult parsePayload(String rawPayload) {
    final trimmed = rawPayload.trim();
    if (!trimmed.startsWith(prefix)) {
      return const QrParseResult(isValid: false);
    }
    final binId = trimmed.substring(prefix.length).trim();
    if (binId.isEmpty) {
      return const QrParseResult(isValid: false);
    }
    return QrParseResult(
      isValid: true,
      entityType: 'bin',
      entityId: binId,
    );
  }

  static Future<QrResolution> resolveBinQr(
    String rawPayload,
    BinRepository binRepo,
  ) async {
    final parseResult = parsePayload(rawPayload);
    if (!parseResult.isValid || parseResult.entityId == null) {
      return const QrResolution(
        status: QrResolutionStatus.invalidFormat,
        errorMessage: 'Invalid QR code format',
      );
    }

    final bin = await binRepo.getBin(parseResult.entityId!);
    if (bin == null) {
      return const QrResolution(
        status: QrResolutionStatus.notFound,
        errorMessage: 'Bin not found',
      );
    }

    if (bin.isArchived) {
      return QrResolution(
        status: QrResolutionStatus.archived,
        bin: bin,
        errorMessage: 'Bin is archived',
      );
    }

    return QrResolution(
      status: QrResolutionStatus.valid,
      bin: bin,
    );
  }
}
