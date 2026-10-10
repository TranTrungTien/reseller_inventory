import '../../../core/domain/value_objects/money.dart';
import '../../inventory/domain/item.dart';
import '../../inventory/domain/item_photo.dart';

class TurboIntakeSession {
  const TurboIntakeSession({
    required this.id,
    required this.workspaceId,
    required this.locationId,
    required this.binId,
    required this.binCode,
    this.locationName,
    required this.startedAt,
    this.itemsAdded = const [],
    this.photosAdded = const [],
    this.defaultCost,
    this.defaultSource,
    this.totalHaulCost,
    this.haulItemCount,
  });

  final String id;
  final String workspaceId;
  final String locationId;
  final String binId;
  final String binCode;
  final String? locationName;
  final DateTime startedAt;
  final List<Item> itemsAdded;
  final List<ItemPhoto> photosAdded;
  final Money? defaultCost;
  final String? defaultSource;
  final Money? totalHaulCost;
  final int? haulItemCount;

  int get sessionCount => itemsAdded.length;

  Money? get effectiveCostPerItem {
    if (defaultCost != null) return defaultCost;
    if (totalHaulCost != null && haulItemCount != null && haulItemCount! > 0) {
      final perItemMinor =
          (totalHaulCost!.amountInMinorUnits / haulItemCount!).round();
      return Money.fromMinorUnits(perItemMinor, totalHaulCost!.currencyCode);
    }
    return null;
  }

  TurboIntakeSession copyWith({
    String? id,
    String? workspaceId,
    String? locationId,
    String? binId,
    String? binCode,
    String? locationName,
    DateTime? startedAt,
    List<Item>? itemsAdded,
    List<ItemPhoto>? photosAdded,
    Money? defaultCost,
    String? defaultSource,
    Money? totalHaulCost,
    int? haulItemCount,
  }) {
    return TurboIntakeSession(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      locationId: locationId ?? this.locationId,
      binId: binId ?? this.binId,
      binCode: binCode ?? this.binCode,
      locationName: locationName ?? this.locationName,
      startedAt: startedAt ?? this.startedAt,
      itemsAdded: itemsAdded ?? this.itemsAdded,
      photosAdded: photosAdded ?? this.photosAdded,
      defaultCost: defaultCost ?? this.defaultCost,
      defaultSource: defaultSource ?? this.defaultSource,
      totalHaulCost: totalHaulCost ?? this.totalHaulCost,
      haulItemCount: haulItemCount ?? this.haulItemCount,
    );
  }
}
