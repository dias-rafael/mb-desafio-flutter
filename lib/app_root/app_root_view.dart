import 'package:coinmarketcap/bootstraps/environment_config.dart';
import 'package:flutter/material.dart';

class AppRootView extends StatelessWidget {
  const AppRootView({required this.environmentConfig, super.key});

  final EnvironmentConfig environmentConfig;

  @override
  Widget build(BuildContext context) {
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
