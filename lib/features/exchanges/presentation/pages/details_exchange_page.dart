import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_entity.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_details_cubit.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsExchangePage extends StatelessWidget {
  const DetailsExchangePage({super.key, required this.exchangeDetail});

  final ExchangeDetailEntity exchangeDetail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //TODO: fetchAssets with exchangeId
      create: (_) =>
          DependencyService.resolve<ExchangeDetailsCubit>()
            ..fetchAssets(exchangeId: exchangeDetail.id),
      child: DetailsExchangeContent(exchangeDetail: exchangeDetail),
    );
  }
}

class DetailsExchangeContent extends StatefulWidget {
  const DetailsExchangeContent({super.key, required this.exchangeDetail});

  final ExchangeDetailEntity exchangeDetail;

  @override
  State<DetailsExchangeContent> createState() => _DetailsExchangeContentState();
}

class _DetailsExchangeContentState extends State<DetailsExchangeContent> {
  Future<void> _launchWebsite(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    }
  }

  Widget _buildUrlsSection(BuildContext context) {
    final urls = widget.exchangeDetail.urls;
    final Map<String, List<String>> urlMap = {
      'Website': urls.website,
      'Fee': urls.fee,
      'Twitter': urls.twitter,
      'Blog': urls.blog,
      'Chat': urls.chat,
    };

    List<Widget> urlWidgets = [];
    urlMap.forEach((label, links) {
      if (links.isNotEmpty) {
        urlWidgets.add(
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        );
        urlWidgets.addAll(
          links.map(
            (url) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: InkWell(
                onTap: () => _launchWebsite(url),
                child: Text(
                  url,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        );
        urlWidgets.add(const SizedBox(height: 8));
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: urlWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.current;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(loc.detailsTitle),
      ),
      body: BlocConsumer<ExchangeDetailsCubit, ExchangeDetailsState>(
        listener: (context, state) {
          if (state is ExchangeDetailsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final assets = state.assets?.data.toList() ?? [];

          return Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: widget.exchangeDetail.logo.isNotEmpty
                        ? Image.network(
                            widget.exchangeDetail.logo,
                            width: 80,
                            height: 80,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported, size: 80),
                          )
                        : const Icon(Icons.image, size: 80),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.exchangeDetail.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('${loc.id}: ${widget.exchangeDetail.id}'),
                  const SizedBox(height: 8),
                  if (widget.exchangeDetail.description != null)
                    Text(
                      widget.exchangeDetail.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const SizedBox(height: 16),
                  _buildUrlsSection(context),
                  const SizedBox(height: 16),
                  Text('${loc.makerFee}: ${widget.exchangeDetail.makerFee}'),
                  Text('${loc.takerFee}: ${widget.exchangeDetail.takerFee}'),
                  const SizedBox(height: 8),
                  if (widget.exchangeDetail.dateLaunched != null)
                    Text(
                      loc.launched(
                        DateFormat.yMd(
                          Localizations.localeOf(context).toString(),
                        ).format(widget.exchangeDetail.dateLaunched!.toLocal()),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Divider(),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      loc.currencies,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (state is ExchangeDetailsLoading)
                    Column(
                      children: [
                        const SizedBox(height: 24),
                        const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ...assets.map(
                    (asset) => ListTile(
                      title: Text(asset.currency.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.priceUSD(
                              NumberFormat.currency(
                                locale: Localizations.localeOf(
                                  context,
                                ).toString(),
                                symbol: '\$',
                                decimalDigits: 2,
                              ).format(asset.currency.priceUsd),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (assets.isEmpty && state is! ExchangeDetailsLoading)
                    Center(child: Text(loc.noDataAvailable)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
