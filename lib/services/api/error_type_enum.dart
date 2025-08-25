// coverage:ignore-file
import 'package:collection/collection.dart';

enum ErrorType {
  unknown;

  const ErrorType();

  static ErrorType? getById(String id) {
    return ErrorType.values.firstWhereOrNull((element) => element.name == id);
  }

  String get localizedDescription {
    return 'An unknown error occurred';
    // final NavigationService navigationService =
    //     DependencyService.resolve<NavigationService>();
    // final context = navigationService.rootNavigatorKey.currentContext;
    // final localization = AppLocalizations.of(context!)!;
    // switch (this) {
    //   default:
    //     return localization.unknownError;
    // }
  }
}
