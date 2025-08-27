// coverage:ignore-file
import 'package:coinmarketcap/app_router.dart';
import 'package:coinmarketcap/bootstraps/environment_config.dart';
import 'package:coinmarketcap/features/exchanges/data/datasources/exchange_api_client.dart';
import 'package:coinmarketcap/features/exchanges/data/repositories/exchange_repository_impl.dart';
import 'package:coinmarketcap/features/exchanges/domain/repositories/exchange_repository.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_assets_usecase.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_detail_usecase.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchanges_usecase.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_cubit.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_details_cubit.dart';
import 'package:coinmarketcap/services/api/api_request_handler.dart';
import 'package:coinmarketcap/services/api/api_response_handler.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:coinmarketcap/services/navigation_service.dart';

class AppInitialization {
  static AppInitialization? _appInit;

  AppInitialization._internal();

  static Future<void> init(EnvironmentConfig environmentConfig) async {
    _appInit ??= AppInitialization._internal();
    await _appInit!._init(environmentConfig);
  }

  Future<void> _init(EnvironmentConfig environmentConfig) async {
    DependencyService.registerLazySingleton<EnvironmentConfig>(
      () => environmentConfig,
    );
    await _setupDI();
  }

  //Dependency injection
  Future<void> _setupDI() async {
    DependencyService.registerLazySingleton<ApiRequestHandler>(
      ApiRequestHandler.new,
    );
    DependencyService.registerLazySingleton<ApiResponseHandler>(
      ApiResponseHandler.new,
    );

    DependencyService.registerSingleton<AppRouter>(AppRouter());
    DependencyService.registerSingleton<NavigationService>(NavigationService());

    // Exchanges
    DependencyService.registerFactory<ExchangeApiClient>(
      () => ExchangeApiClientImpl(),
    );

    DependencyService.registerFactory<ExchangeRepository>(
      () => ExchangeRepositoryImpl(
        DependencyService.resolve<ExchangeApiClient>(),
      ),
    );

    DependencyService.registerFactory<FetchExchangesUseCase>(
      () => FetchExchangesUseCase(
        DependencyService.resolve<ExchangeRepository>(),
      ),
    );

    DependencyService.registerFactory<FetchExchangeDetailUseCase>(
      () => FetchExchangeDetailUseCase(
        DependencyService.resolve<ExchangeRepository>(),
      ),
    );

    DependencyService.registerFactory<FetchExchangeAssetsUseCase>(
      () => FetchExchangeAssetsUseCase(
        DependencyService.resolve<ExchangeRepository>(),
      ),
    );

    DependencyService.registerFactory<ExchangeCubit>(
      () => ExchangeCubit(
        DependencyService.resolve<FetchExchangesUseCase>(),
        DependencyService.resolve<FetchExchangeDetailUseCase>(),
      ),
    );

    DependencyService.registerFactory<ExchangeDetailsCubit>(
      () => ExchangeDetailsCubit(
        DependencyService.resolve<FetchExchangeAssetsUseCase>(),
      ),
    );
  }
}
