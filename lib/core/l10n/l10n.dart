// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `CoinMarketCap`
  String get appTitle {
    return Intl.message('CoinMarketCap', name: 'appTitle', desc: '', args: []);
  }

  /// `Exchanges List`
  String get listTitle {
    return Intl.message(
      'Exchanges List',
      name: 'listTitle',
      desc: '',
      args: [],
    );
  }

  /// `Exchange Details`
  String get detailsTitle {
    return Intl.message(
      'Exchange Details',
      name: 'detailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorTitle {
    return Intl.message(
      'An error occurred',
      name: 'errorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get errorMessage {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred.`
  String get errorUnknown {
    return Intl.message(
      'An unknown error occurred.',
      name: 'errorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Spot Volume USD: {value}`
  String spotVolumeUSD(Object value) {
    return Intl.message(
      'Spot Volume USD: $value',
      name: 'spotVolumeUSD',
      desc: '',
      args: [value],
    );
  }

  /// `Launched: {value}`
  String launched(Object value) {
    return Intl.message(
      'Launched: $value',
      name: 'launched',
      desc: '',
      args: [value],
    );
  }

  /// `Error fetching more exchanges`
  String get errorFetchingMoreExchanges {
    return Intl.message(
      'Error fetching more exchanges',
      name: 'errorFetchingMoreExchanges',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching exchanges`
  String get errorFetchingExchanges {
    return Intl.message(
      'Error fetching exchanges',
      name: 'errorFetchingExchanges',
      desc: '',
      args: [],
    );
  }

  /// `No exchange detail available`
  String get noExchangeDetailAvailable {
    return Intl.message(
      'No exchange detail available',
      name: 'noExchangeDetailAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching exchange details`
  String get errorFetchingDetailExchanges {
    return Intl.message(
      'Error fetching exchange details',
      name: 'errorFetchingDetailExchanges',
      desc: '',
      args: [],
    );
  }

  /// `Maker Fee`
  String get makerFee {
    return Intl.message('Maker Fee', name: 'makerFee', desc: '', args: []);
  }

  /// `Taker Fee`
  String get takerFee {
    return Intl.message('Taker Fee', name: 'takerFee', desc: '', args: []);
  }

  /// `ID`
  String get id {
    return Intl.message('ID', name: 'id', desc: '', args: []);
  }

  /// `Error fetching exchange assets`
  String get errorFetchingExchangeAssets {
    return Intl.message(
      'Error fetching exchange assets',
      name: 'errorFetchingExchangeAssets',
      desc: '',
      args: [],
    );
  }

  /// `Currencies`
  String get currencies {
    return Intl.message('Currencies', name: 'currencies', desc: '', args: []);
  }

  /// `Price USD: {value}`
  String priceUSD(Object value) {
    return Intl.message(
      'Price USD: $value',
      name: 'priceUSD',
      desc: '',
      args: [value],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
