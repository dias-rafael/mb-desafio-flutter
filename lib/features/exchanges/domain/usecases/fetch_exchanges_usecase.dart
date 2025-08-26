import 'package:coinmarketcap/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:coinmarketcap/services/api/api_response_model.dart';

class FetchExchangesUseCase {
  final ExchangeRepository repository;

  FetchExchangesUseCase(this.repository);

  Future<ApiResponseModel> call({int? pageNumber, int? pageLimit}) {
    return repository.fetchExchanges(
      pageNumber: pageNumber,
      pageLimit: pageLimit,
    );
  }
}
