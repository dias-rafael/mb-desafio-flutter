import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_urls_entity.dart';

class ExchangeDetailEntity {
  final int id;
  final String name;
  final String slug;
  final String logo;
  final String? description;
  final DateTime? dateLaunched;
  final String? notice;
  final List<String> countries;
  final List<String> fiats;
  final List<String>? tags;
  final String type;
  final double makerFee;
  final double takerFee;
  final int weeklyVisits;
  final double spotVolumeUsd;
  final DateTime? spotVolumeLastUpdated;
  final ExchangeUrlsEntity urls;

  const ExchangeDetailEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.logo,
    this.description,
    this.dateLaunched,
    required this.notice,
    required this.countries,
    required this.fiats,
    required this.tags,
    required this.type,
    required this.makerFee,
    required this.takerFee,
    required this.weeklyVisits,
    required this.spotVolumeUsd,
    this.spotVolumeLastUpdated,
    required this.urls,
  });
}
