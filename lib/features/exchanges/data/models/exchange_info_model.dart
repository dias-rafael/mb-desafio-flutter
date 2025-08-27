import '../../domain/entities/exchange_info_entity.dart';

class ExchangeInfoModel extends ExchangeInfoEntity {
  const ExchangeInfoModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.isActive,
    super.status,
    required super.firstHistoricalData,
    required super.lastHistoricalData,
  });

  factory ExchangeInfoModel.fromJson(Map<String, dynamic> json) {
    return ExchangeInfoModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      isActive: json['is_active'] as int,
      status: json['status'] as String?,
      firstHistoricalData: DateTime.parse(
        json['first_historical_data'] as String,
      ),
      lastHistoricalData: DateTime.parse(
        json['last_historical_data'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'is_active': isActive,
      'status': status,
      'first_historical_data': firstHistoricalData.toIso8601String(),
      'last_historical_data': lastHistoricalData.toIso8601String(),
    };
  }
}
