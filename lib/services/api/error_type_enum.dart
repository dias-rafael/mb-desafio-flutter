// coverage:ignore-file
import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:collection/collection.dart';

enum ErrorType {
  apiError,
  unknown;

  const ErrorType();

  static ErrorType? getById(String id) {
    return ErrorType.values.firstWhereOrNull((element) => element.name == id);
  }

  String get localizedDescription {
    final loc = AppLocalizations.current;
    switch (this) {
      case ErrorType.apiError:
        return loc.errorMessage;
      case ErrorType.unknown:
        return loc.errorUnknown;
    }
  }
}
