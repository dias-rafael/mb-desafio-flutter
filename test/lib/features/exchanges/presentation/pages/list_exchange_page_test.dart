import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_response_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_urls_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_detail_usecase.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchanges_usecase.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_cubit.dart';
import 'package:coinmarketcap/features/exchanges/presentation/pages/list_exchange_page.dart';
import 'package:coinmarketcap/services/api/api_response_handler.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:coinmarketcap/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../helpers.dart';

class MockFetchExchangesUseCase extends Mock implements FetchExchangesUseCase {}

class MockNavigationService extends Mock implements NavigationService {}

class MockFetchExchangeDetailUseCase extends Mock
    implements FetchExchangeDetailUseCase {}

void main() {
  late ExchangeCubit cubit;
  late MockFetchExchangesUseCase mockFetchExchangesUseCase;
  late MockFetchExchangeDetailUseCase mockFetchExchangeDetailUseCase;
  late MockNavigationService mockNavigationService;
  late ApiResponseHandler apiResponseHandler;

  setUp(() {
    AppLocalizations.delegate.load(const Locale('en'));
    mockFetchExchangesUseCase = MockFetchExchangesUseCase();
    mockFetchExchangeDetailUseCase = MockFetchExchangeDetailUseCase();
    cubit = ExchangeCubit(
      mockFetchExchangesUseCase,
      mockFetchExchangeDetailUseCase,
    );
    mockNavigationService = MockNavigationService();
    apiResponseHandler = ApiResponseHandler();
    DependencyService.registerSingleton<NavigationService>(
      mockNavigationService,
    );
    DependencyService.registerSingleton<ExchangeCubit>(cubit);
  });

  tearDown(() {
    DependencyService.reset();
  });

  testWidgets('ListExchangePage shows exchanges', (tester) async {
    final exchanges = {
      "270": ExchangeDetailEntity(
        id: 270,
        name: "Binance",
        slug: "binance",
        logo: "https://s2.coinmarketcap.com/static/img/exchanges/64x64/270.png",
        description:
            "Launched in Jul-2017, Binance is a centralized exchange based in Malta.",
        dateLaunched: DateTime.parse("2017-07-14T00:00:00.000Z"),
        notice: null,
        countries: const [],
        fiats: const ["AED", "USD"],
        tags: null,
        type: "",
        makerFee: 0.02,
        takerFee: 0.04,
        weeklyVisits: 5123451,
        spotVolumeUsd: 66926283498.60113,
        spotVolumeLastUpdated: DateTime.parse("2021-05-06T01:20:15.451Z"),
        urls: ExchangeUrlsEntity(
          website: const ["https://www.binance.com/"],
          twitter: const ["https://twitter.com/binance"],
          blog: const [],
          chat: const ["https://t.me/binanceexchange"],
          fee: const ["https://www.binance.com/fees.html"],
        ),
      ),
    };

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
                "data": {"270": {
                "id": 270,
                "name": "Binance",
                "slug": "binance",
                "logo": "https://s2.coinmarketcap.com/static/img/exchanges/64x64/270.png",
                "description": "Launched in Jul-2017, Binance is a centralized exchange based in Malta.",
                "date_launched": "2017-07-14T00:00:00.000Z",
                "notice": null,
                "countries": [],
                "fiats": ["AED", "USD"],
                "tags": null,
                "type": "",
                "maker_fee": 0.02,
                "taker_fee": 0.04,
                "weekly_visits": 5123451,
                "spot_volume_usd": 66926283498.60113,
                "spot_volume_last_updated": "2021-05-06T01:20:15.451Z",
                "urls": {
                  "website": ["https://www.binance.com/"],
                  "twitter": ["https://twitter.com/binance"],
                  "blog": [],
                  "chat": ["https://t.me/binanceexchange"],
                  "fee": ["https://www.binance.com/fees.html"]
                }
              }},
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

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: BlocProvider<ExchangeCubit>.value(
          value: cubit
            ..emit(
              ExchangesLoaded(
                exchanges: ExchangeDetailResponseEntity(
                  data: exchanges,
                  status: FakeStatusModel(),
                ),
                pageNumber: 1,
                pageLimit: 10,
                hasMore: false,
              ),
            ),
          child: Builder(builder: (context) => ListExchangePage()),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Binance'), findsOneWidget);
  });
}
