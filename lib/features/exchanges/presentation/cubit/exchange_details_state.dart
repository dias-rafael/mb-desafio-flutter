part of 'exchange_details_cubit.dart';

abstract class ExchangeDetailsState extends Equatable {
  final WalletBalanceResponseEntity? assets;

  const ExchangeDetailsState({this.assets});

  @override
  List<Object?> get props => [assets];
}

class ExchangeDetailsInitial extends ExchangeDetailsState {}

class ExchangeDetailsLoading extends ExchangeDetailsState {
  const ExchangeDetailsLoading({super.assets});

  @override
  List<Object?> get props => [assets];
}

class ExchangeDetailsLoaded extends ExchangeDetailsState {
  const ExchangeDetailsLoaded({super.assets});

  @override
  List<Object?> get props => [assets];
}

class ExchangeDetailsError extends ExchangeDetailsState {
  final String message;

  const ExchangeDetailsError(this.message, {super.assets});

  @override
  List<Object?> get props => [message, assets];
}
