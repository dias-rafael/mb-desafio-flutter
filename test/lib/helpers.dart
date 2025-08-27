import 'package:coinmarketcap/features/exchanges/data/models/status_model.dart';

class FakeStatusModel extends StatusModel {
  FakeStatusModel()
    : super(
        timestamp: DateTime.parse("2025-08-27T00:43:59.293Z"),
        errorCode: 0,
        errorMessage: '',
        elapsed: 18,
        creditCount: 1,
        notice: '',
      );
}
