import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/data/models/status_model.dart';
import 'package:coinmarketcap/features/exchanges/data/models/wallet_balance_model.dart';
import 'package:coinmarketcap/features/exchanges/data/models/wallet_balance_response_model.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/wallet_balance_response_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_assets_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exchange_details_state.dart';

class ExchangeDetailsCubit extends Cubit<ExchangeDetailsState> {
  final FetchExchangeAssetsUseCase fetchExchangeAssetsUseCase;

  ExchangeDetailsCubit(this.fetchExchangeAssetsUseCase)
    : super(ExchangeDetailsInitial());

  final loc = AppLocalizations.current;

  Future<void> fetchAssets({required int exchangeId}) async {
    emit(ExchangeDetailsLoading());
    try {
      final response = await fetchExchangeAssetsUseCase(exchangeId: exchangeId);
      if (response.data != null) {
        final exchangeAssets = WalletBalanceResponseModel.fromJson(
          response.data!,
        );

        exchangeAssets.data.sort(
          (a, b) => a.currency.name.compareTo(b.currency.name),
        );

        final seenIds = <int>{};
        final uniqueAssets = <WalletBalanceModel>[];

        for (final asset in exchangeAssets.data) {
          if (seenIds.add(asset.currency.cryptoId)) {
            uniqueAssets.add(asset as WalletBalanceModel);
          }
        }

        emit(
          ExchangeDetailsLoaded(
            assets: WalletBalanceResponseModel(
              data: uniqueAssets,
              status: exchangeAssets.status as StatusModel,
            ),
          ),
        );
      } else {
        emit(ExchangeDetailsError(loc.noDataAvailable));
      }
    } catch (e) {
      debugPrint('Error fetching exchange assets: $e');
      emit(ExchangeDetailsError(loc.errorFetchingExchangeAssets));
    }
  }
}
