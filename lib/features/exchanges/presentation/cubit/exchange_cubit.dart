import 'package:coinmarketcap/core/l10n/l10n.dart';
import 'package:coinmarketcap/features/exchanges/data/models/exchange_detail_response_model.dart';
import 'package:coinmarketcap/features/exchanges/data/models/exchange_info_response_model.dart';
import 'package:coinmarketcap/features/exchanges/domain/entities/exchange_detail_response_entity.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchange_detail_usecase.dart';
import 'package:coinmarketcap/features/exchanges/domain/usecases/fetch_exchanges_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exchange_state.dart';

class ExchangeCubit extends Cubit<ExchangeState> {
  final FetchExchangesUseCase fetchExchangesUseCase;
  final FetchExchangeDetailUseCase fetchExchangeDetailUseCase;

  ExchangeCubit(this.fetchExchangesUseCase, this.fetchExchangeDetailUseCase)
    : super(ExchangesInitial());

  final loc = AppLocalizations.current;

  Future<void> fetchExchanges() async {
    emit(
      ExchangesLoading(
        exchanges: state.exchanges,
        pageNumber: state.pageNumber,
        pageLimit: state.pageLimit,
      ),
    );
    try {
      final response = await fetchExchangesUseCase(
        pageNumber: state.pageNumber,
        pageLimit: state.pageLimit,
      );
      if (response.data != null) {
        final exchanges = ExchangeInfoResponseModel.fromJson(response.data!);
        await fetchExchangeDetail(
          slugs: exchanges.data.map((e) => e.slug).toList(),
        );
      } else {
        emit(ExchangesError(loc.noDataAvailable));
      }
    } catch (e) {
      debugPrint('Error fetching exchanges: $e');
      emit(ExchangesError(loc.errorFetchingExchanges));
    }
  }

  Future<void> fetchMoreExchanges() async {
    emit(
      ExchangesLoaded(
        exchanges: state.exchanges,
        pageNumber: state.pageNumber + 1,
        pageLimit: state.pageLimit,
        hasMore: true,
      ),
    );
    try {
      final response = await fetchExchangesUseCase(
        pageNumber: state.pageNumber,
        pageLimit: state.pageLimit,
      );
      if (response.data != null) {
        final exchanges = ExchangeInfoResponseModel.fromJson(response.data!);
        final slugs = exchanges.data.map((e) => e.slug).toList();
        if (slugs.isNotEmpty) {
          await fetchExchangeDetail(slugs: slugs);
        } else {
          emit(
            ExchangesLoaded(
              exchanges: state.exchanges,
              pageNumber: state.pageNumber + 1,
              pageLimit: state.pageLimit,
              hasMore: false,
            ),
          );
        }
      } else {
        emit(
          ExchangesLoaded(
            exchanges: state.exchanges,
            pageNumber: state.pageNumber + 1,
            pageLimit: state.pageLimit,
            hasMore: false,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error fetching more exchanges: $e');
      emit(
        ExchangesError(
          loc.errorFetchingMoreExchanges,
          exchanges: state.exchanges,
          pageNumber: state.pageNumber,
          pageLimit: state.pageLimit,
        ),
      );
    }
  }

  Future<void> fetchExchangeDetail({required List<String> slugs}) async {
    try {
      final response = await fetchExchangeDetailUseCase(slugs: slugs);
      if (response.data != null) {
        ExchangeDetailResponseEntity? moreExchanges = state.exchanges;
        final newExchanges = ExchangeDetailResponseModel.fromJson(
          response.data!,
        );

        if (moreExchanges == null) {
          moreExchanges = newExchanges;
        } else {
          moreExchanges.data.addAll(newExchanges.data);
        }
        emit(
          ExchangesLoaded(
            exchanges: moreExchanges,
            pageNumber: state.pageNumber + 1,
            pageLimit: state.pageLimit,
          ),
        );
      } else {
        emit(
          ExchangesError(
            loc.noExchangeDetailAvailable,
            exchanges: state.exchanges,
            pageNumber: state.pageNumber,
            pageLimit: state.pageLimit,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error fetching detail exchange: $e');
      emit(
        ExchangesError(
          loc.errorFetchingDetailExchanges,
          exchanges: state.exchanges,
          pageNumber: state.pageNumber,
          pageLimit: state.pageLimit,
        ),
      );
    }
  }
}
