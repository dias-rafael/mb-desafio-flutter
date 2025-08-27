import 'package:coinmarketcap/features/exchanges/data/models/status_model.dart';
import 'package:coinmarketcap/features/exchanges/data/models/wallet_balance_model.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/wallet_balance_response_entity.dart';

class WalletBalanceResponseModel extends WalletBalanceResponseEntity {
  const WalletBalanceResponseModel({
    required List<WalletBalanceModel> data,
    required StatusModel status,
  }) : super(data: data, status: status);

  factory WalletBalanceResponseModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceResponseModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => WalletBalanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: StatusModel(
        timestamp: DateTime.parse(json['status']['timestamp'] as String),
        errorCode: json['status']['error_code'] as int,
        errorMessage: json['status']['error_message'] as String? ?? '',
        elapsed: json['status']['elapsed'] as int,
        creditCount: json['status']['credit_count'] as int,
        notice: json['status']['notice'] as String? ?? '',
      ),
    );
  }
}
