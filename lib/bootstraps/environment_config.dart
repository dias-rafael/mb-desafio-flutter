import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

enum Environment { DEV, QA, PROD }

class EnvironmentConfig {
  final String apiKey;
  final Environment environment;
  final bool isDebug;

  const EnvironmentConfig({
    required this.apiKey,
    required this.environment,
    required this.isDebug,
  });

  factory EnvironmentConfig.fromEnv(Map<String, String> env) {
    final apiKey = env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('API_KEY is not set in environment variables.');
    }

    final envString = env['ENVIRONMENT'];
    if (envString == null || envString.isEmpty) {
      throw Exception('ENVIRONMENT is not set in environment variables.');
    }

    final environment = Environment.values.firstWhereOrNull(
      (e) => e.name.toUpperCase() == envString.toUpperCase(),
    );

    if (environment == null) {
      throw Exception('Invalid ENVIRONMENT value: $envString');
    }

    final isDebug = kDebugMode;

    return EnvironmentConfig(
      apiKey: apiKey,
      environment: environment,
      isDebug: isDebug,
    );
  }
}
