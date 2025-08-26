import 'package:coinmarketcap/bootstraps/environment_config.dart';
import 'package:coinmarketcap/core/utils/uri_paths.dart';
import 'package:coinmarketcap/services/api/api_method.dart';
import 'package:coinmarketcap/services/api/api_request_handler.dart';
import 'package:coinmarketcap/services/api/api_request_model.dart';
import 'package:coinmarketcap/services/api/api_response_model.dart';
import 'package:coinmarketcap/services/dependency_service.dart';

abstract class ExchangeApiClient {
  Future<ApiResponseModel> fetchExchanges({int? pageNumber, int? pageLimit});
  Future<ApiResponseModel> fetchExchangeDetail({required List<String> slugs});
}

class ExchangeApiClientImpl extends ExchangeApiClient {
  final apiRequestHandler = DependencyService.resolve<ApiRequestHandler>();
  final environmentConfig = DependencyService.resolve<EnvironmentConfig>();
  String get baseURL => environmentConfig.baseUrl;

  @override
  Future<ApiResponseModel> fetchExchanges({
    int? pageNumber,
    int? pageLimit,
  }) async {
    final endpoint = URIPaths.getListExchangeMap;

    final request = ApiRequestModel(
      endpoint: '$baseURL$endpoint',
      apiMethod: ApiMethod.GET,
      queryParameters: {'start': pageNumber ?? 1, 'limit': pageLimit ?? 20},
    );

    return await apiRequestHandler.request(request);
  }

  @override
  Future<ApiResponseModel> fetchExchangeDetail({
    required List<String> slugs,
  }) async {
    final endpoint = URIPaths.getDetailExchangeInfo;

    final request = ApiRequestModel(
      endpoint: '$baseURL$endpoint',
      apiMethod: ApiMethod.GET,
      queryParameters: {'slug': slugs.join(',')},
    );

    return await apiRequestHandler.request(request);
  }
}
