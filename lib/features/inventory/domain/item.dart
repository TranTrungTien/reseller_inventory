import '../../../core/domain/value_objects/enums.dart';
import '../../../core/domain/value_objects/money.dart';

class Item {
  const Item({
    required this.id,
    required this.workspaceId,
    required this.sku,
    required this.title,
    this.description,
    this.status = ItemStatus.stored,
    this.locationId,
    this.binId,
    this.cost,
    this.currency = 'USD',
    this.brand,
    this.category,
    this.size,
    this.color,
    this.condition,
    this.source,
    this.sourceDate,
    this.soldAt,
    this.salePrice,
    this.marketplaceOrderRef,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.revision = 1,
  });

  final String id;
  final String workspaceId;
  final String sku;
  final String title;
  final String? description;
  final ItemStatus status;
  final String? locationId;
  final String? binId;
  final Money? cost;
  final String currency;
  final String? brand;
  final String? category;
  final String? size;
  final String? color;
  final String? condition;
  final String? source;
  final DateTime? sourceDate;
  final DateTime? soldAt;
  final Money? salePrice;
  final String? marketplaceOrderRef;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int revision;

  Item copyWith({
    String? id,
    String? workspaceId,
    String? sku,
    String? title,
    String? description,
    ItemStatus? status,
    String? locationId,
    String? binId,
    Money? cost,
    String? currency,
    String? brand,
    String? category,
    String? size,
    String? color,
    String? condition,
    String? source,
    DateTime? sourceDate,
    DateTime? soldAt,
    Money? salePrice,
    String? marketplaceOrderRef,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? revision,
  }) {
    return Item(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      sku: sku ?? this.sku,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      locationId: locationId ?? this.locationId,
      binId: binId ?? this.binId,
      cost: cost ?? this.cost,
      currency: currency ?? this.currency,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      size: size ?? this.size,
      color: color ?? this.color,
      condition: condition ?? this.condition,
      source: source ?? this.source,
      sourceDate: sourceDate ?? this.sourceDate,
      soldAt: soldAt ?? this.soldAt,
      salePrice: salePrice ?? this.salePrice,
      marketplaceOrderRef: marketplaceOrderRef ?? this.marketplaceOrderRef,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      revision: revision ?? this.revision,
    );
  }
}
