import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_detail_usecase.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchanges_usecase.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_cubit.dart';
import 'package:coinmarketcap/services/api/api_response_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockFetchExchangesUseCase extends Mock implements FetchExchangesUseCase {}

class MockFetchExchangeDetailUseCase extends Mock
    implements FetchExchangeDetailUseCase {}

void main() {
  late ExchangeCubit cubit;
  late MockFetchExchangesUseCase mockFetchExchangesUseCase;
  late MockFetchExchangeDetailUseCase mockFetchExchangeDetailUseCase;
  late ApiResponseHandler apiResponseHandler;

  setUp(() {
    AppLocalizations.delegate.load(const Locale('en'));
    mockFetchExchangesUseCase = MockFetchExchangesUseCase();
    mockFetchExchangeDetailUseCase = MockFetchExchangeDetailUseCase();
    apiResponseHandler = ApiResponseHandler();
    cubit = ExchangeCubit(
      mockFetchExchangesUseCase,
      mockFetchExchangeDetailUseCase,
    );
  });

  group('ExchangeCubit', () {
    test('initial state is ExchangesInitial', () {
      expect(cubit.state, isA<ExchangesInitial>());
    });

    blocTest<ExchangeCubit, ExchangeState>(
      'emits [ExchangesLoading, ExchangesLoaded] when fetchExchanges succeeds',
      build: () {
        when(
          () => mockFetchExchangesUseCase(
            pageNumber: any(named: 'pageNumber'),
            pageLimit: any(named: 'pageLimit'),
          ),
        ).thenAnswer(
          (_) async => apiResponseHandler.handleResponse(
            http.Response('''
              {
                "data": [],
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
        when(
          () => mockFetchExchangeDetailUseCase(slugs: any(named: 'slugs')),
        ).thenAnswer(
          (_) async => apiResponseHandler.handleResponse(
            http.Response('''
              {
                "data": {},
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
      act: (cubit) => cubit.fetchExchanges(),
      expect: () => [isA<ExchangesLoading>(), isA<ExchangesLoaded>()],
    );

    blocTest<ExchangeCubit, ExchangeState>(
      'emits [ExchangesLoading, ExchangesError] when fetchExchanges throws',
      build: () {
        when(
          () => mockFetchExchangesUseCase(
            pageNumber: any(named: 'pageNumber'),
            pageLimit: any(named: 'pageLimit'),
          ),
        ).thenThrow(Exception('error'));
        return cubit;
      },
      act: (cubit) => cubit.fetchExchanges(),
      expect: () => [isA<ExchangesLoading>(), isA<ExchangesError>()],
    );
  });
}
