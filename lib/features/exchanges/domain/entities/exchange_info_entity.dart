class ExchangeInfoEntity {
  final int id;
  final String name;
  final String slug;
  final int isActive;
  final String? status;
  final DateTime firstHistoricalData;
  final DateTime lastHistoricalData;

  const ExchangeInfoEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.isActive,
    this.status,
    required this.firstHistoricalData,
    required this.lastHistoricalData,
  });
}
