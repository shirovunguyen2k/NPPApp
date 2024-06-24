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
      Map<String, dynamic> json, T Function(dynamic) converter) {
    return BaseResponse<T>(
      statusCode: json['statusCode'],
      message: json['message'],
      totalRecord: json['totalRecord'],
      data: json['data'] != null ? converter(json['data']) : null,
    );
  }
}

BaseResponse<T> convertResponse<T>(
    Map<String, dynamic> json, T Function(dynamic) converter) {
  return BaseResponse<T>.fromJson(json, converter);
}
