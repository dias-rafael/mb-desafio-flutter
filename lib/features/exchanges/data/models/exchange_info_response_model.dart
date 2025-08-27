import 'package:flutter/foundation.dart';

import '../../domain/entities/exchange_info_response_entity.dart';
import 'exchange_info_model.dart';
import 'status_model.dart';

class ExchangeInfoResponseModel extends ExchangeInfoResponseEntity {
  const ExchangeInfoResponseModel({
    required List<ExchangeInfoModel> data,
    required StatusModel status,
  }) : super(data: data, status: status);

  factory ExchangeInfoResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      return ExchangeInfoResponseModel(
        data: (json['data'] as List<dynamic>)
            .map((e) => ExchangeInfoModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: StatusModel.fromJson(json['status'] as Map<String, dynamic>),
      );
    } catch (e, stacktrace) {
      debugPrint('Error parsing ExchangeInfoModel: $e\n$stacktrace');
      throw Exception(stacktrace);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as ExchangeInfoModel).toJson()).toList(),
      'status': (status as StatusModel).toJson(),
    };
  }
}
