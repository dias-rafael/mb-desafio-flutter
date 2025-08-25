import 'dart:async';

import 'package:coinmarketcap/app_root/app_root_view.dart';
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

        runApp(AppRootView(environmentConfig: environmentConfig));
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
