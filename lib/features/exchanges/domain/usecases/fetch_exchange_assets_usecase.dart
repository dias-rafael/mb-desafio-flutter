import 'package:coinmarketcap/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:coinmarketcap/services/api/api_response_model.dart';

class FetchExchangeAssetsUseCase {
  final ExchangeRepository repository;

  FetchExchangeAssetsUseCase(this.repository);

  Future<ApiResponseModel> call({required int exchangeId}) {
    return repository.fetchExchangeAssets(exchangeId: exchangeId);
  }
}
