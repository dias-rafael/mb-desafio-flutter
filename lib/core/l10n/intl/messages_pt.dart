// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m0(value) => "Lançado em: ${value}";

  static String m1(value) => "Preço USD: ${value}";

  static String m2(value) => "Volume Spot USD: ${value}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("CoinMarketCap"),
    "currencies": MessageLookupByLibrary.simpleMessage("Moedas"),
    "detailsTitle": MessageLookupByLibrary.simpleMessage(
      "Detalhes da Exchange",
    ),
    "errorFetchingDetailExchanges": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar detalhes das exchanges",
    ),
    "errorFetchingExchangeAssets": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar ativos da exchange",
    ),
    "errorFetchingExchanges": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar exchanges",
    ),
    "errorFetchingMoreExchanges": MessageLookupByLibrary.simpleMessage(
      "Erro ao buscar mais exchanges",
    ),
    "errorMessage": MessageLookupByLibrary.simpleMessage(
      "Algo deu errado. Por favor, tente novamente mais tarde.",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage("Ocorreu um erro"),
    "errorUnknown": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro desconhecido.",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID"),
    "launched": m0,
    "listTitle": MessageLookupByLibrary.simpleMessage("Lista de Exchanges"),
    "makerFee": MessageLookupByLibrary.simpleMessage("Taxa do Maker"),
    "noDataAvailable": MessageLookupByLibrary.simpleMessage(
      "Nenhum dado disponível",
    ),
    "noExchangeDetailAvailable": MessageLookupByLibrary.simpleMessage(
      "Nenhum detalhe de exchange disponível",
    ),
    "priceUSD": m1,
    "spotVolumeUSD": m2,
    "takerFee": MessageLookupByLibrary.simpleMessage("Taxa do Taker"),
  };
}
