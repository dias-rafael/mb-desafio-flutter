import '../../domain/entities/status_entity.dart';

class StatusModel extends StatusEntity {
  const StatusModel({
    required super.timestamp,
    required super.errorCode,
    required super.errorMessage,
    required super.elapsed,
    required super.creditCount,
    required super.notice,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      timestamp: DateTime.parse(json['timestamp'] as String),
      errorCode: json['error_code'] as int,
      errorMessage: json['error_message'] as String? ?? '',
      elapsed: json['elapsed'] as int,
      creditCount: json['credit_count'] as int,
      notice: json['notice'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'error_code': errorCode,
      'error_message': errorMessage,
      'elapsed': elapsed,
      'credit_count': creditCount,
      'notice': notice,
    };
  }
}
