import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/presentation/cubit/exchange_cubit.dart';
import 'package:coinmarketcap/features/exchanges/presentation/widgets/exchange_list_tile.dart';
import 'package:coinmarketcap/services/dependency_service.dart';
import 'package:coinmarketcap/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListExchangePage extends StatelessWidget {
  const ListExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DependencyService.resolve<ExchangeCubit>()..fetchExchanges,
      child: ListExchangeContent(),
    );
  }
}

class ListExchangeContent extends StatefulWidget {
  const ListExchangeContent({super.key});

  @override
  State<ListExchangeContent> createState() => _ListExchangeContentState();
}

class _ListExchangeContentState extends State<ListExchangeContent> {
  final ScrollController _scrollController = ScrollController();
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ExchangeCubit>().fetchExchanges();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isFetching) {
      _isFetching = true;
      context.read<ExchangeCubit>().fetchMoreExchanges().whenComplete(
        () => _isFetching = false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService =
        DependencyService.resolve<NavigationService>();
    final loc = AppLocalizations.current;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(loc.appTitle),
      ),
      body: BlocConsumer<ExchangeCubit, ExchangeState>(
        listener: (context, state) {
          if (state is ExchangesError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final currentPage = state.pageNumber;

          if (state is ExchangesLoading && currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          }

          final exchanges = state.exchanges?.data.values.toList() ?? [];
          return ListView.separated(
            controller: _scrollController,
            itemCount: exchanges.length + (state.hasMore ? 1 : 0),
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              if (index < exchanges.length) {
                final exchange = exchanges[index];
                return ExchangeListTile(
                  exchange: exchange,
                  navigationService: navigationService,
                  loc: loc,
                );
              } else if (state.hasMore && state is! ExchangesError) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
