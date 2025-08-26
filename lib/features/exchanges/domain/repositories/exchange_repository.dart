import 'package:coinmarketcap/services/api/api_response_model.dart';

abstract class ExchangeRepository {
  Future<ApiResponseModel> fetchExchanges({int? pageNumber, int? pageLimit});
  Future<ApiResponseModel> fetchExchangeDetail({required List<String> slugs});
}
