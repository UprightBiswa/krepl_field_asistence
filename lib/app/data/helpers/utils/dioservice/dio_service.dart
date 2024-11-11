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
    await setDeviceToken();
  }

  Future<void> setDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _deviceToken = prefs.getString('deviceToken');
    print('Device Token set in DioService: $_deviceToken');
  }

  Future<Response> post(String endPoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      queryParams = queryParams ?? {};

      if (_deviceToken == null) {
        // Handle null device token
        return _handleNullDeviceToken();
      } else {
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

  Future<Response> postFormData(String endPoint, FormData formData) async {
    try {
      if (_deviceToken == null) {
        return _handleNullDeviceToken();
      } else {
        formData.fields.add(MapEntry('device_token', _deviceToken!));
      }

      final response = await _dio.post(endPoint, data: formData);
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

  Response _handleNullDeviceToken() {
    getx.Get.defaultDialog(
      barrierDismissible: false,
      title: 'Login Required',
      content: const Text('Please login again'),
      actions: [
        TextButton(
          onPressed: () {
            getx.Get.offAll(() => const SignIn(),
                transition: getx.Transition.rightToLeftWithFade);
          },
          child: const Text('Login'),
        ),
      ],
    );
    throw Exception('Device Token is null');
  }
}
