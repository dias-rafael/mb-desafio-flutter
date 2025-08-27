import 'package:coinmarketcap/features/exchanges/domain/entities/platform_entity.dart';

class PlatformModel extends PlatformEntity {
  const PlatformModel({
    required super.cryptoId,
    required super.symbol,
    required super.name,
  });

  factory PlatformModel.fromJson(Map<String, dynamic> json) {
    return PlatformModel(
      cryptoId: json['crypto_id'] as int,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
    );
  }
}
