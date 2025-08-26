import 'package:coinmarketcap/features/exchanges/data/models/exchange_urls_model.dart';

import '../../domain/entities/exchange_detail_entity.dart';

class ExchangeDetailModel extends ExchangeDetailEntity {
  const ExchangeDetailModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.logo,
    required super.description,
    required super.dateLaunched,
    required super.notice,
    required super.countries,
    required super.fiats,
    required super.tags,
    required super.type,
    required super.makerFee,
    required super.takerFee,
    required super.weeklyVisits,
    required super.spotVolumeUsd,
    required super.spotVolumeLastUpdated,
    required ExchangeUrlsModel super.urls,
  });

  factory ExchangeDetailModel.fromJson(Map<String, dynamic> json) {
    return ExchangeDetailModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      logo: json['logo'] as String,
      description: json['description'] as String,
      dateLaunched: DateTime.parse(json['date_launched'] as String),
      notice: json['notice'] as String?,
      countries: (json['countries'] as List<dynamic>).cast<String>(),
      fiats: (json['fiats'] as List<dynamic>).cast<String>(),
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      type: json['type'] as String,
      makerFee: (json['maker_fee'] as num).toDouble(),
      takerFee: (json['taker_fee'] as num).toDouble(),
      weeklyVisits: json['weekly_visits'] as int,
      spotVolumeUsd: (json['spot_volume_usd'] as num).toDouble(),
      spotVolumeLastUpdated: DateTime.parse(
        json['spot_volume_last_updated'] as String,
      ),
      urls: ExchangeUrlsModel.fromJson(json['urls'] as Map<String, dynamic>),
    );
  }
}
