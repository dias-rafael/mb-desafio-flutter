import '../../domain/entities/exchange_detail_response_entity.dart';
import 'exchange_detail_model.dart';
import 'status_model.dart';

class ExchangeDetailResponseModel extends ExchangeDetailResponseEntity {
  const ExchangeDetailResponseModel({
    required Map<String, ExchangeDetailModel> data,
    required StatusModel status,
  }) : super(data: data, status: status);

  factory ExchangeDetailResponseModel.fromJson(Map<String, dynamic> json) {
    final dataMap = (json['data'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(
        key,
        ExchangeDetailModel.fromJson(value as Map<String, dynamic>),
      ),
    );
    return ExchangeDetailResponseModel(
      data: dataMap,
      status: StatusModel.fromJson(json['status'] as Map<String, dynamic>),
    );
  }
}
