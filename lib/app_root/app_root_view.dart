import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/presentation/pages/list_coins_page.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:coinmarketcap/services/navigation_service.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppRootView extends StatelessWidget {
  const AppRootView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService =
        DependencyService.resolve<NavigationService>();

    return MaterialApp(
      title: 'CoinMarketCap',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      localeListResolutionCallback: (allLocales, supportedLocales) {
        final locale = allLocales?.first.languageCode;
        if (locale != null) {
          final localeFound = supportedLocales.firstWhereOrNull(
            (value) => value.languageCode.contains(locale),
          );
          if (localeFound != null) {
            return localeFound;
          }
        }

        return const Locale('en', 'US');
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      navigatorKey: navigationService.rootNavigatorKey,
      home: ListCoinsPage(),
    );
  }
}
