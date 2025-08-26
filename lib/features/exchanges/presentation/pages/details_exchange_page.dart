import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_entity.dart';
import 'package:flutter/material.dart';

class DetailsExchangePage extends StatelessWidget {
  const DetailsExchangePage({super.key, required this.exchangeDetail});

  final ExchangeDetailEntity exchangeDetail;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.current;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(loc.detailsTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(exchangeDetail.name)],
        ),
      ),
    );
  }
}
