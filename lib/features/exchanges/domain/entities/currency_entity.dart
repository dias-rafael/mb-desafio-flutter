class CurrencyEntity {
  final int cryptoId;
  final double priceUsd;
  final String symbol;
  final String name;

  const CurrencyEntity({
    required this.cryptoId,
    required this.priceUsd,
    required this.symbol,
    required this.name,
  });
}
