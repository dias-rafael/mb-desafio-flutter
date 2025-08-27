import 'package:coinmarketcap/features/exchanges/domain/entities/currency_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/platform_entity.dart';

class WalletBalanceEntity {
  final String walletAddress;
  final num balance;
  final PlatformEntity platform;
  final CurrencyEntity currency;

  const WalletBalanceEntity({
    required this.walletAddress,
    required this.balance,
    required this.platform,
    required this.currency,
  });
}
