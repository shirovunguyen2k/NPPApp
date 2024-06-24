import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/features/user/repositories/auth_repository.dart';

class ApiService {
  final String baseUrl;

  ApiService(String baseURL, {required this.baseUrl});

  final httpHeader = <String, String>{
    'X_REQUEST_UDID': '00000000-0000-0000-0000-000000000000',
    'X_TOKEN': '00000000-0000-0000-0000-000000000000',
  };

  Future<dynamic> get(String endpoint, [Map<String, String>? queryParameters]) async {
    final url = Uri.https(baseUrl, endpoint, queryParameters ?? {});

    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Missing access token');
    }

    final headers = {
      ...httpHeader,
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.get(url, headers: headers);

    _handleResponse(response);

    return _decodeJson(response);
  }

  Future<dynamic> post(String endpoint, body) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Missing access token');
    }

    final headers = {
      ...httpHeader,
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.post(url, headers: headers, body: body);

    _handleResponse(response);

    return _decodeJson(response);
  }

  Future<dynamic> put(String endpoint, body) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Missing access token');
    }

    final headers = {
      ...httpHeader,
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.put(url, headers: headers, body: body);

    _handleResponse(response);

    return _decodeJson(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    final accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception('Missing access token');
    }

    final headers = {
      ...httpHeader,
      'Authorization': 'Bearer $accessToken',
    };

    final response = await http.delete(url, headers: headers);

    _handleResponse(response);

    return _decodeJson(response);
  }

  // You can add other methods for PUT, DELETE, etc. as needed.

  Future<void> _handleResponse(http.Response response) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return; // Successful response
    } else {
      throw Exception(
          'API request failed with status code: ${response.statusCode}');
    }
  }

  dynamic _decodeJson(http.Response response) {
    try {
      final dynamic decodedData = jsonDecode(response.body);
      return decodedData;
    } on FormatException catch (e) {
      throw Exception('Failed to decode JSON response: $e');
    }
  }
}
