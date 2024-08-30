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
    String? deviceToken = prefs.getString('deviceToken');
    _deviceToken = deviceToken;
    print('Device Token set in DioService: $_deviceToken');
  }

  Future<Response> post(String endPoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      print('$_deviceToken: ');
      queryParams = queryParams ?? {};
      if (_deviceToken != null) {
        queryParams['device_token'] = _deviceToken;
      } else {
        getx.Get.defaultDialog(
          barrierDismissible: false,
          title: 'Device Token is null',
          content: const Text('Please login again'),
          actions: [
            TextButton(
              onPressed: () {
                getx.Get.to(() => const SignIn(),
                    transition: getx.Transition.rightToLeftWithFade);
              },
              child: const Text('Login'),
            ),
          ],
        );
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
