import 'package:coinmarketcap/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:coinmarketcap/services/api/api_response_model.dart';

class FetchExchangeDetailUseCase {
  final ExchangeRepository repository;

  FetchExchangeDetailUseCase(this.repository);

  Future<ApiResponseModel> call({required List<String> slugs}) {
    return repository.fetchExchangeDetail(slugs: slugs);
  }
}
