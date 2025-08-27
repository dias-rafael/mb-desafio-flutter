import 'package:coinmarketcap/features/exchanges/data/models/currency_model.dart';
import 'package:coinmarketcap/features/exchanges/data/models/platform_model.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/wallet_ballance_entity.dart';

class WalletBalanceModel extends WalletBalanceEntity {
  const WalletBalanceModel({
    required super.walletAddress,
    required super.balance,
    required PlatformModel super.platform,
    required CurrencyModel super.currency,
  });

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceModel(
      walletAddress: json['wallet_address'] as String,
      balance: json['balance'] as num,
      platform: PlatformModel.fromJson(
        json['platform'] as Map<String, dynamic>,
      ),
      currency: CurrencyModel.fromJson(
        json['currency'] as Map<String, dynamic>,
      ),
    );
  }
}
