import 'error_type_enum.dart';

class ApiResponseErrorModel {
  final String errorMessage;

  ApiResponseErrorModel({
    required this.errorMessage,
  });

  factory ApiResponseErrorModel.fromMap(dynamic map) {
    return ApiResponseErrorModel(
      errorMessage: map['id'] != null
          ? ErrorType.getById(map['id'])?.localizedDescription ?? ErrorType.unknown.localizedDescription
          : map['message'] ?? ErrorType.unknown.localizedDescription,
    );
  }
}
