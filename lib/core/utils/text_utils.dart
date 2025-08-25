import 'dart:convert';

String formatJsonToString(dynamic response) {
  final String result = _isNull(response);
  if (result.isEmpty) {
    return result;
  }
  final object = jsonDecode(result);
  final prettyString = const JsonEncoder.withIndent('  ').convert(object);
  return prettyString;
}

String _isNull(dynamic value) {
  return (value != null) ? value.toString() : '';
}
