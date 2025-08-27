import 'package:coinmarketcap/app_routes.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_entity.dart';
import 'package:coinmarketcap/features/exchanges/presentation/pages/details_exchange_page.dart';
import 'package:coinmarketcap/features/exchanges/presentation/pages/list_exchange_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final Map<String, Route Function(Object?)> _routes = {};
  AppRouter() {
    _registerRoutes();
  }
  void _registerRoutes() {
    _routes[AppRoutes.LISTCOINS] = (args) => MaterialPageRoute(
      builder: (context) => const ListExchangePage(),
      settings: RouteSettings(name: AppRoutes.LISTCOINS, arguments: args),
    );
    _routes[AppRoutes.DETAILSCOIN] = (args) => MaterialPageRoute(
      builder: (context) =>
          DetailsExchangePage(exchangeDetail: args as ExchangeDetailEntity),
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
