import 'package:dio/dio.dart';
import 'package:field_asistence/app/modules/auth/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constrants/api_base_url.dart';

class DioService {
  final Dio _dio = Dio();
  String? _deviceToken;

  DioService() {
    _dio.options.baseUrl = BaseURL.baseUrl;
    _initialize();
  }

  Future<void> _initialize() async {
    await _setDeviceToken();
  }

  Future<void> _setDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _deviceToken = prefs.getString('deviceToken');
    if (_deviceToken == null) {
      print('Warning: Device token is null. Retry or reauthenticate!');
    } else {
      print('Device Token initialized: $_deviceToken');
    }
  }

  Future<Response> post(String endPoint,
      {Map<String, dynamic>? queryParams}) async {
    queryParams ??= {};

    if (_deviceToken == null) return _handleNullDeviceToken();
    queryParams['device_token'] = _deviceToken;

    try {
      print(_deviceToken);
      final response = await _dio.post(endPoint, queryParameters: queryParams);
      print(response.statusCode);
      print(response.data);
      return _handleResponse(response);
    } catch (e) {
      return _handleDioError(e);
    }
  }

  Future<Response> postFormData(String endPoint, FormData formData) async {
    if (_deviceToken == null) return _handleNullDeviceToken();
    formData.fields.add(MapEntry('device_token', _deviceToken!));

    try {
      final response = await _dio.post(endPoint, data: formData);
      print(response.data);
      return _handleResponse(response);
    } catch (e) {
      return _handleDioError(e);
    }
  }

  Response _handleResponse(Response response) {
    if (response.data is Map && response.data['success'] == false) {
      String errorMessage =
          (response.data['message'] ?? '').toLowerCase().trim();

      if (errorMessage == 'user not found') {
        _logoutUser();
        return response;
      }
      return response;
      //throw Exception(response.data['message'] ?? 'Unknown error occurred');
    }
    return response;
  }

  Response _handleDioError(dynamic e) {
    if (e is DioException) {
      print('DioError: ${e.message}');
      throw Exception('DioError: ${e.message}');
    }
    print(e);
    throw Exception('Failed to make API request: $e');
  }

  Response _handleNullDeviceToken() {
    _logoutUser();
    throw Exception('Device Token is null');
  }

  void _logoutUser() {
    getx.Get.defaultDialog(
      barrierDismissible: false,
      title: 'Login Required',
      content: const Text('Please login again'),
      actions: [
        TextButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear(); // Clear stored session data
            getx.Get.offAll(() => const SignIn(),
                transition: getx.Transition.rightToLeftWithFade);
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
