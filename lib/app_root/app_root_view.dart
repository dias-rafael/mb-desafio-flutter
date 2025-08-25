import 'package:coinmarketcap/bootstraps/environment_config.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:flutter/material.dart';

class AppRootView extends StatelessWidget {
  const AppRootView({super.key});

  @override
  Widget build(BuildContext context) {
    final environmentConfig = DependencyService.resolve<EnvironmentConfig>();

    return MaterialApp(
      title: 'CoinMarketCap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('CoinMarketCap'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Environment Configuration'),
              Text('API Key: ${environmentConfig.apiKey}'),
              Text('Environment: ${environmentConfig.environment.name}'),
              Text('Is Debug: ${environmentConfig.isDebug}'),
            ],
          ),
        ),
      ),
    );
  }
}
