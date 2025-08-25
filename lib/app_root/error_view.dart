import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final StackTrace stackTrace;

  const ErrorView({super.key, required this.error, required this.stackTrace});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      restorationScopeId: 'CoinMarketCap',
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return Center(child: Text('$error \n ${stackTrace.toString()}'));
          },
        ),
      ),
    );
  }
}
