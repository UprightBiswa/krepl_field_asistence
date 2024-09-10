import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/constrants/api_base_url.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../auth/sign_in_page.dart';

class AppInfoController extends GetxController {
  final Dio _dio = Dio();
  String? _deviceToken;

  @override
  onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    await setDeviceToken();
  }

  var isLoading = false.obs;
  var appInfoResponse = Rxn<AppInfo>();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<void> setDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _deviceToken = prefs.getString('deviceToken');
    print('Device Token set in DioService: $_deviceToken');
  }

  Future<void> getAppInfo({
    required BuildContext context,
  }) async {
    isLoading(true);
    try {
      bool isConnected = await _connectivityService.checkInternet();
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      if (_deviceToken == null) {
        // Handle null device token
        return _handleNullDeviceToken();
      } else {
        final response = await _dio.post(
          '${BaseURL.baseUrl}fa_app_info',
          queryParameters: {
            'device_token': _deviceToken,
          },
        );

        if (response.statusCode == 200) {
          print('Successful Response: ${response.data}');
          final responseData = response.data['data'];
          appInfoResponse.value = AppInfo.fromJson(responseData);
        } else {
          print('Error Response: ${response.data}');
        }
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

  _handleNullDeviceToken() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Device Token is null',
      content: const Text('Please login again'),
      actions: [
        TextButton(
          onPressed: () {
            Get.offAll(() => const SignIn(),
                transition: Transition.rightToLeftWithFade);
          },
          child: const Text('Login'),
        ),
      ],
    );
    throw Exception('Device Token is null');
  }
}

class AppInfo {
  final int id;
  final String appName;
  final String appVersion;
  final String remarks;
  final String priority;
  final String appLink;

  AppInfo({
    required this.id,
    required this.appName,
    required this.appVersion,
    required this.remarks,
    required this.priority,
    required this.appLink,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
      id: json['id'],
      appName: json['app_name'],
      appVersion: json['app_version'].toString(),
      remarks: json['remarks'],
      priority: json['priority'].toString(),
      appLink: json['app_link'],
    );
  }
}
