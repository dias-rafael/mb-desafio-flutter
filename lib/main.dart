import 'dart:async';

import 'package:coinmarketcap/app_root/error_view.dart';
import 'package:coinmarketcap/bootstraps/environment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      try {
        await dotenv.load(fileName: "environment.env");

        final environmentConfig = EnvironmentConfig.fromEnv(dotenv.env);

        runApp(MyApp(environmentConfig: environmentConfig));
      } catch (e, stackTrace) {
        runApp(ErrorView(error: e.toString(), stackTrace: stackTrace));

        debugPrint(e.toString());
        debugPrint(stackTrace.toString());
      }
    },
    (dynamic exception, StackTrace stacktrace) async {
      FlutterErrorDetails error = FlutterErrorDetails(
        exception: exception,
        stack: stacktrace,
      );
      if (error.exception is Error) {
        debugPrintStack(stackTrace: (error.exception as Error).stackTrace);
      } else {
        debugPrint(error.exception.toString());
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.environmentConfig, super.key});

  final EnvironmentConfig environmentConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        environmentConfig: environmentConfig,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.environmentConfig,
  });

  final String title;
  final EnvironmentConfig environmentConfig;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Main page'),
            Text('API Key: ${widget.environmentConfig.apiKey}'),
            Text('Environment: ${widget.environmentConfig.environment.name}'),
            Text('Is Debug: ${widget.environmentConfig.isDebug}'),
          ],
        ),
      ),
    );
  }
}
