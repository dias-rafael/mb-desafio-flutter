import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_assets_usecase.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_details_cubit.dart';
import 'package:coinmarketcap/services/api/api_response_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockFetchExchangeAssetsUseCase extends Mock
    implements FetchExchangeAssetsUseCase {}

void main() {
  late ExchangeDetailsCubit cubit;
  late MockFetchExchangeAssetsUseCase mockFetchExchangeAssetsUseCase;
  late ApiResponseHandler apiResponseHandler;

  setUp(() {
    AppLocalizations.delegate.load(const Locale('en'));
    mockFetchExchangeAssetsUseCase = MockFetchExchangeAssetsUseCase();
    apiResponseHandler = ApiResponseHandler();
    cubit = ExchangeDetailsCubit(mockFetchExchangeAssetsUseCase);
  });

  group('ExchangeDetailsCubit', () {
    test('initial state is ExchangeDetailsInitial', () {
      expect(cubit.state, isA<ExchangeDetailsInitial>());
    });

    blocTest<ExchangeDetailsCubit, ExchangeDetailsState>(
      'emits [ExchangeDetailsLoading, ExchangeDetailsLoaded] when fetchAssets succeeds',
      build: () {
        when(
          () => mockFetchExchangeAssetsUseCase(
            exchangeId: any(named: 'exchangeId'),
          ),
        ).thenAnswer(
          (_) async => apiResponseHandler.handleResponse(
            http.Response('''
                    {
                      "data": [
                        {
                          "wallet_address": "0x123",
                          "balance": 100,
                          "platform": {
                            "crypto_id": 1,
                            "symbol": "ETH",
                            "name": "Ethereum"
                          },
                          "currency": {
                            "crypto_id": 10,
                            "price_usd": 1.0,
                            "symbol": "AAA",
                            "name": "Alpha"
                          }
                        },
                        {
                          "wallet_address": "0x456",
                          "balance": 200,
                          "platform": {
                            "crypto_id": 1,
                            "symbol": "ETH",
                            "name": "Ethereum"
                          },
                          "currency": {
                            "crypto_id": 20,
                            "price_usd": 2.0,
                            "symbol": "BBB",
                            "name": "Beta"
                          }
                        }
                      ],
                      "status": {
                        "timestamp": "2025-08-27T00:43:59.293Z",
                        "error_code": 0,
                        "error_message": null,
                        "elapsed": 18,
                        "credit_count": 1,
                        "notice": null
                      }
                    }
                    ''', 200),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchAssets(exchangeId: 1),
      expect: () => [
        isA<ExchangeDetailsLoading>(),
        isA<ExchangeDetailsLoaded>(),
      ],
    );

    blocTest<ExchangeDetailsCubit, ExchangeDetailsState>(
      'emits [ExchangeDetailsLoading, ExchangeDetailsError] when fetchAssets throws',
      build: () {
        when(
          () => mockFetchExchangeAssetsUseCase(
            exchangeId: any(named: 'exchangeId'),
          ),
        ).thenThrow(Exception('error'));
        return cubit;
      },
      act: (cubit) => cubit.fetchAssets(exchangeId: 1),
      expect: () => [
        isA<ExchangeDetailsLoading>(),
        isA<ExchangeDetailsError>(),
      ],
    );
  });
}
