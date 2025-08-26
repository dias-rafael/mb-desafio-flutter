import 'package:coinmarketcap/app_routes.dart';
import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_entity.dart';
import 'package:coinmarketcap/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExchangeListTile extends StatelessWidget {
  final ExchangeDetailEntity exchange;
  final NavigationService navigationService;
  final AppLocalizations loc;

  const ExchangeListTile({
    super.key,
    required this.exchange,
    required this.navigationService,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: exchange.logo.isNotEmpty
          ? Image.network(
              exchange.logo,
              width: 40,
              height: 40,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
            )
          : const Icon(Icons.image),
      title: Text(exchange.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.spotVolumeUSD(
              NumberFormat.currency(
                locale: Localizations.localeOf(context).toString(),
                symbol: '',
                decimalDigits: 2,
              ).format(exchange.spotVolumeUsd),
            ),
          ),
          if (exchange.dateLaunched != null)
            Text(
              loc.launched(
                DateFormat.yMd(
                  Localizations.localeOf(context).toString(),
                ).format(exchange.dateLaunched!.toLocal()),
              ),
            ),
        ],
      ),
      onTap: () {
        navigationService.pushNamed(AppRoutes.DETAILSCOIN, arguments: exchange);
      },
    );
  }
}
