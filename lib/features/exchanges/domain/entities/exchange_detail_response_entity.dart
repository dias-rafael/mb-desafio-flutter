import 'exchange_detail_entity.dart';
import 'status_entity.dart';

class ExchangeDetailResponseEntity {
  final Map<String, ExchangeDetailEntity> data;
  final StatusEntity status;

  const ExchangeDetailResponseEntity({
    required this.data,
    required this.status,
  });
}
