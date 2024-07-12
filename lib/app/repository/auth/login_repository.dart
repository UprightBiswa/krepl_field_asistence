import 'package:dio/dio.dart';

import '../../data/constrants/api_base_url.dart';
import '../../data/helpers/internet/connectivity_services.dart';


class LoginRepository {
  final Dio _dio = Dio();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<Map<String, dynamic>> requestOTP(String username) async {
    try {
      bool isConnected = await _connectivityService.checkInternet();
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final response = await _dio.post(
        '${BaseURL.baseUrl}sf_request_otp',
        data: {'username': username},
      );
      return response.data;
    } catch (error) {
      print('Error requesting OTP: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyOTP(String username, String otp, String fcmToken) async {
    try {
      bool isConnected = await _connectivityService.checkInternet();
      if (!isConnected) {
        throw Exception('No internet connection');
      }

      final response = await _dio.post(
        '${BaseURL.baseUrl}sf_verify_otp',
        data: {'username': username, 'otp': otp, 'fcm_token': fcmToken},
      );
      return response.data;
    } catch (error) {
      print('Error verifying OTP: $error');
      rethrow;
    }
  }

}
