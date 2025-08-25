import 'dart:convert';

import 'package:coinmarketcap/core/utils/int_extension.dart';
import 'package:coinmarketcap/core/utils/text_utils.dart';
import 'package:coinmarketcap/services/api/api_response_model.dart';
import 'package:coinmarketcap/services/api/error_type_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiResponseHandler {
  ApiResponseModel handleResponse(Response response) {
    debugPrint(
      '\n*** RESPONSE ***\nURL: ${response.request?.url}\nSTATUS CODE: ${response.statusCode}\nBODY: ${formatJsonToString(response.body)}\n',
    );

    final apiResponseModel = ApiResponseModel();
    apiResponseModel.statusCode = response.statusCode;

    if (response.statusCode.isWithin(200, 299)) {
      if (response.body.isEmpty) {
        apiResponseModel.data = {};
        return apiResponseModel;
      }
      final decodedResponse = jsonDecode(response.body.toString());
      apiResponseModel.data = decodedResponse;
    } else if (response.statusCode.isWithin(300, 599)) {
      apiResponseModel.message = ErrorType.unknown.localizedDescription;
    } else {
      throw Exception(response.body);
    }
    return apiResponseModel;
  }
}
