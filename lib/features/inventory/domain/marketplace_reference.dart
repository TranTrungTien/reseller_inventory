import '../../../core/domain/value_objects/money.dart';

class MarketplaceReference {
  const MarketplaceReference({
    required this.id,
    required this.itemId,
    required this.platform,
    required this.externalId,
    this.listingUrl,
    this.status,
    this.listedAt,
    this.soldAt,
    this.price,
  });

  final String id;
  final String itemId;
  final String platform;
  final String externalId;
  final String? listingUrl;
  final String? status;
  final DateTime? listedAt;
  final DateTime? soldAt;
  final Money? price;

  MarketplaceReference copyWith({
    String? id,
    String? itemId,
    String? platform,
    String? externalId,
    String? listingUrl,
    String? status,
    DateTime? listedAt,
    DateTime? soldAt,
    Money? price,
  }) {
    return MarketplaceReference(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      platform: platform ?? this.platform,
      externalId: externalId ?? this.externalId,
      listingUrl: listingUrl ?? this.listingUrl,
      status: status ?? this.status,
      listedAt: listedAt ?? this.listedAt,
      soldAt: soldAt ?? this.soldAt,
      price: price ?? this.price,
    );
  }
}
