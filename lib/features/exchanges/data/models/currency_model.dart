import 'package:coinmarketcap/features/exchanges/domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  const CurrencyModel({
    required super.cryptoId,
    required super.priceUsd,
    required super.symbol,
    required super.name,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      cryptoId: json['crypto_id'] as int,
      priceUsd: (json['price_usd'] as num).toDouble(),
      symbol: json['symbol'] as String,
      name: json['name'] as String,
    );
  }
}
