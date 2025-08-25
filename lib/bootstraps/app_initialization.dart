// coverage:ignore-file
import 'package:coinmarketcap/app_router.dart';
import 'package:coinmarketcap/bootstraps/environment_config.dart';
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
  }
}
