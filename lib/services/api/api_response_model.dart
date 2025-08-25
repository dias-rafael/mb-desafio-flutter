// coverage:ignore-file
import 'api_response_error_model.dart';

class ApiResponseModel {
  Map<String, dynamic>? data;
  ApiResponseErrorModel? errors;
  int? statusCode;
  String? message;
}
