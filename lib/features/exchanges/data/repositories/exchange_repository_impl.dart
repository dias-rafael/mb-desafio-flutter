import 'package:coinmarketcap/features/exchanges/data/datasources/exchange_api_client.dart';
import 'package:coinmarketcap/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:coinmarketcap/services/api/api_response_model.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeApiClient apiClient;

  ExchangeRepositoryImpl(this.apiClient);

  @override
  Future<ApiResponseModel> fetchExchanges({
    int? pageNumber,
    int? pageLimit,
  }) async {
    final responseModel = await apiClient.fetchExchanges(
      pageNumber: pageNumber,
      pageLimit: pageLimit,
    );
    return responseModel;
  }

  @override
  Future<ApiResponseModel> fetchExchangeDetail({
    required List<String> slugs,
  }) async {
    final responseModel = await apiClient.fetchExchangeDetail(slugs: slugs);
    return responseModel;
  }
}
