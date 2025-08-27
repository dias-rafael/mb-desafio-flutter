import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _rootNavigatorKey;

  NavigationService({GlobalKey<NavigatorState>? navigatorKey})
    : _rootNavigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  Route<dynamic>? getCurrentRoute() {
    Route<dynamic>? currentRoute;
    _rootNavigatorKey.currentState?.popUntil((route) {
      currentRoute = route;
      return true;
    });

    return currentRoute;
  }

  Future<T?> push<T extends Object?>(Route<T> route) async {
    return _rootNavigatorKey.currentState?.push<T>(route);
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) async {
    return _rootNavigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Route<T> route, {
    TO? result,
  }) async {
    return _rootNavigatorKey.currentState?.pushReplacement<T, TO>(
      route,
      result: result,
    );
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    return _rootNavigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) async {
    return _rootNavigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  void pop<T extends Object?>([T? result]) {
    _rootNavigatorKey.currentState?.pop(result);
  }

  void popUntil<T extends Object?>(T? params) {
    _rootNavigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
