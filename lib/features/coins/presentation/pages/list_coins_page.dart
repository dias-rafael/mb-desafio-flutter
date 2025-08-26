import 'package:coinmarketcap/bootstraps/environment_config.dart';
import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:flutter/material.dart';

class ListCoinsPage extends StatelessWidget {
  const ListCoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final environmentConfig = DependencyService.resolve<EnvironmentConfig>();
    final loc = AppLocalizations.current;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(loc.listTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('List Coins Page'),
            Text('API Key: ${environmentConfig.apiKey}'),
            Text('Environment: ${environmentConfig.environment.name}'),
            Text('Is Debug: ${environmentConfig.isDebug}'),
          ],
        ),
      ),
    );
  }
}
