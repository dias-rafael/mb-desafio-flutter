import 'package:coinmarketcap/features/coins/domain/entities/exchange_urls_entity.dart';

class ExchangeUrlsModel extends ExchangeUrlsEntity {
  const ExchangeUrlsModel({
    required super.website,
    required super.twitter,
    required super.blog,
    required super.chat,
    required super.fee,
  });

  factory ExchangeUrlsModel.fromJson(Map<String, dynamic> json) {
    return ExchangeUrlsModel(
      website: (json['website'] as List<dynamic>).cast<String>(),
      twitter: (json['twitter'] as List<dynamic>).cast<String>(),
      blog: (json['blog'] as List<dynamic>).cast<String>(),
      chat: (json['chat'] as List<dynamic>).cast<String>(),
      fee: (json['fee'] as List<dynamic>).cast<String>(),
    );
  }
}
