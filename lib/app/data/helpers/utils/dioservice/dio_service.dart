import 'package:dio/dio.dart';

import '../../../constrants/api_base_url.dart';

class DioService {
  final Dio _dio = Dio();
  String? _deviceToken;

  DioService() {
    // Add interceptors or other Dio configurations here if needed
    _dio.options.baseUrl = BaseURL.baseUrl;
  }

  void setDeviceToken(String token) {
    _deviceToken = token;
  }

  Future<Response> post(String endPoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      queryParams = queryParams ?? {};
      if (_deviceToken != null) {
        queryParams['device_token'] = _deviceToken;
      }
      final response = await _dio.post(endPoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.message}');
        throw Exception('DioError: ${e.message}');
      }
      print('Exception: $e');
      throw Exception('Failed to make POST request: $e');
    }
  }
}
