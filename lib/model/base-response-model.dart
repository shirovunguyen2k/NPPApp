class BaseResponse<T> {
  final int statusCode;
  final String message;
  final int totalRecord;
  final T? data;

  const BaseResponse({
    required this.statusCode,
    required this.message,
    required this.totalRecord,
    required this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) converter) {
    return BaseResponse<T>(
      statusCode: json['StatusCode'],
      message: json['Message'],
      totalRecord: json['TotalRecord'],
      data: json['Data'] != null ? converter(json['Data']) : null,
    );
  }
}

BaseResponse<T> convertResponse<T>(
    Map<String, dynamic> json, T Function(Map<String, dynamic>) converter) {
  return BaseResponse<T>.fromJson(json, converter);
}
