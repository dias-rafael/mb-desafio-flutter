import 'package:get_it/get_it.dart';

class DependencyService {
  static void registerSingleton<T extends Object>(T instance) {
    GetIt.instance.registerSingleton(instance);
  }

  static void registerLazySingleton<T extends Object>(
    T Function() instanceBuilder,
  ) {
    GetIt.instance.registerLazySingleton(instanceBuilder);
  }

  static void registerFactory<T extends Object>(T Function() instanceBuilder) {
    GetIt.instance.registerFactory<T>(instanceBuilder);
  }

  static T resolve<T extends Object>() {
    return GetIt.instance.get<T>();
  }

  static void unregister<T extends Object>() {
    GetIt.instance.unregister<T>();
  }

  static void reset() {
    GetIt.instance.reset();
  }
}
