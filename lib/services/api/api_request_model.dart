import 'package:coinmarketcap/services/api/api_method.dart';

class ApiRequestModel {
  final ApiMethod apiMethod;
  final String endpoint;
  final Map<String, String>? headers;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? queryParameters;

  const ApiRequestModel({
    required this.apiMethod,
    required this.endpoint,
    this.headers,
    this.body,
    this.queryParameters,
  });
}
