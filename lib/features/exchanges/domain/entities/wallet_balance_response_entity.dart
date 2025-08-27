import 'package:coinmarketcap/features/exchanges/domain/entities/status_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/wallet_ballance_entity.dart';

class WalletBalanceResponseEntity {
  final List<WalletBalanceEntity> data;
  final StatusEntity status;

  const WalletBalanceResponseEntity({required this.data, required this.status});
}
