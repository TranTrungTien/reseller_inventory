class ScanResult {
  const ScanResult({
    required this.code,
    this.rawFormat,
  });

  final String code;
  final String? rawFormat;
}

abstract class BarcodeScannerService {
  Future<ScanResult?> scanBarcode();
  Stream<ScanResult> get continuousScanStream;
}

class StubBarcodeScannerService implements BarcodeScannerService {
  @override
  Future<ScanResult?> scanBarcode() async {
    return null;
  }

  @override
  Stream<ScanResult> get continuousScanStream => const Stream.empty();
}
