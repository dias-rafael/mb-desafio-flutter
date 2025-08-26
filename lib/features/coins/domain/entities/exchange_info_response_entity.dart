import 'exchange_info_entity.dart';
import 'status_entity.dart';

class ExchangeInfoResponseEntity {
  final List<ExchangeInfoEntity> data;
  final StatusEntity status;

  const ExchangeInfoResponseEntity({required this.data, required this.status});
}
