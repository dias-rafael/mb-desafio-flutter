part of 'exchange_cubit.dart';

abstract class ExchangeState extends Equatable {
  final ExchangeDetailResponseEntity? exchanges;
  final int pageNumber;
  final int pageLimit;
  final bool hasMore;

  const ExchangeState({
    this.exchanges,
    this.pageNumber = 1,
    this.pageLimit = 10,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [exchanges, pageNumber, pageLimit];
}

class ExchangesInitial extends ExchangeState {}

class ExchangesLoading extends ExchangeState {
  const ExchangesLoading({super.exchanges, super.pageNumber, super.pageLimit});

  @override
  List<Object?> get props => [exchanges, pageNumber, pageLimit];
}

class ExchangesLoaded extends ExchangeState {
  const ExchangesLoaded({
    super.exchanges,
    super.pageNumber,
    super.pageLimit,
    super.hasMore,
  });

  @override
  List<Object?> get props => [exchanges, pageNumber, pageLimit, hasMore];
}

class ExchangesError extends ExchangeState {
  final String message;

  const ExchangesError(
    this.message, {
    super.exchanges,
    super.pageNumber,
    super.pageLimit,
  });

  @override
  List<Object?> get props => [message, exchanges, pageNumber, pageLimit];
}
