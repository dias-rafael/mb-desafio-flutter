import 'package:coinmarketcap/app_routes.dart';
import 'package:coinmarketcap/features/exchanges/presentation/pages/details_coin_page.dart';
import 'package:coinmarketcap/features/exchanges/presentation/pages/list_coins_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final Map<String, Route Function(Object?)> _routes = {};
  AppRouter() {
    _registerRoutes();
  }
  void _registerRoutes() {
    _routes[AppRoutes.LISTCOINS] = (args) => MaterialPageRoute(
      builder: (context) => const ListCoinsPage(),
      settings: RouteSettings(name: AppRoutes.LISTCOINS, arguments: args),
    );
    _routes[AppRoutes.DETAILSCOIN] = (args) => MaterialPageRoute(
      builder: (context) => DetailsCoinPage(),
      settings: RouteSettings(name: AppRoutes.DETAILSCOIN, arguments: args),
    );
  }

  Route<dynamic>? getRouteByName(String? routeName, {Object? arguments}) {
    if (routeName == null) return null;
    final routeBuilder = _routes[routeName];
    if (routeBuilder != null) {
      return routeBuilder(arguments);
    }
    return null;
  }
}
