import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_urls_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_assets_usecase.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_details_cubit.dart';
import 'package:coinmarketcap/features/exchanges/presentation/pages/details_exchange_page.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';

class MockFetchExchangeAssetsUseCase extends Mock
    implements FetchExchangeAssetsUseCase {}

void main() {
  late ExchangeDetailsCubit cubit;
  late ExchangeDetailEntity exchangeDetail;
  late MockFetchExchangeAssetsUseCase mockFetchExchangeAssetsUseCase;

  setUpAll(() async {
    await initializeDateFormatting('en');
  });

  setUp(() {
    AppLocalizations.delegate.load(const Locale('en'));
    exchangeDetail = ExchangeDetailEntity(
      id: 1,
      name: 'Binance',
      slug: 'binance',
      logo: '',
      description: 'Test exchange',
      dateLaunched: DateTime(2020, 1, 1),
      notice: null,
      countries: [],
      fiats: [],
      tags: null,
      type: '',
      makerFee: 0.01,
      takerFee: 0.02,
      weeklyVisits: 0,
      spotVolumeUsd: 0,
      spotVolumeLastUpdated: DateTime(2020, 1, 1),
      urls: ExchangeUrlsEntity(
        website: ['https://binance.com'],
        twitter: [],
        blog: [],
        chat: [],
        fee: [],
      ),
    );
    mockFetchExchangeAssetsUseCase = MockFetchExchangeAssetsUseCase();
    cubit = ExchangeDetailsCubit(mockFetchExchangeAssetsUseCase);
    DependencyService.registerSingleton<ExchangeDetailsCubit>(cubit);
  });

  tearDown(() {
    DependencyService.reset();
  });

  testWidgets('DetailsExchangePage shows exchange name and description', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        home: BlocProvider<ExchangeDetailsCubit>.value(
          value: cubit,
          child: DetailsExchangePage(exchangeDetail: exchangeDetail),
        ),
      ),
    );

    expect(find.text('Binance'), findsOneWidget);
    expect(find.text('Test exchange'), findsOneWidget);
    expect(find.textContaining('https://binance.com'), findsOneWidget);
  });
}
