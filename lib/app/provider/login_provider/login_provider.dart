import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/constrants/api_base_url.dart';
import '../../data/helpers/utils/flutter_tost/tost_service.dart';
import '../../data/local_db/login_db.dart';
import '../../model/login/otp_request_model.dart';
import '../../model/login/user_details_reponse.dart';
import '../../model/login/verify_otp_response_model.dart';
import '../../modules/widgets/loading/custom_login_widget.dart';
import '../../repository/auth/auth_token.dart';
import '../../repository/auth/login_repository.dart';


class LoginProvider extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();
  final UserDatabase _userDatabase = UserDatabase();
  final Dio _dio = Dio();
  Future<bool> _checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  VerifyOTPResponse? _loginResponse;
  VerifyOTPResponse? get loginResponse => _loginResponse;
  OTPRequest? _otpRequest;
  OTPRequest? get otpRequest => _otpRequest;

  UserDetailsResponse? _userDetailsResponse;
  UserDetailsResponse? get userDetailsResponse => _userDetailsResponse;

  late UserDetailsResponse _cachedResponse;
  UserDetailsResponse? get cacheRsponse => _cachedResponse;
  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;
  Future<void> requestOTP(String username, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      showCustomLoadingDialog(context, 'Requesting OTP...');

      final response = await _loginRepository.requestOTP(username);
      _otpRequest = OTPRequest.fromJson(response);

      _isLoading = false;
      notifyListeners();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      if (_otpRequest!.success) {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'OTP requested successfully',
            isSuccess: true);
      } else {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'Error: ${_otpRequest!.message}');
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Error requesting OTP: $error');
      }
      // ignore: use_build_context_synchronously
      ToastService.show(context, 'Error requesting OTP');

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  Future<void> verifyOTP(
    String username,
    String otp,
    String fcmToken,
    BuildContext context,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      showCustomLoadingDialog(context, 'Verifying OTP...');

      final response =
          await _loginRepository.verifyOTP(username, otp, fcmToken);
      _loginResponse = VerifyOTPResponse.fromJson(response);

      _isLoading = false;
      notifyListeners();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      if (_loginResponse!.success) {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'OTP verified successfully',
            isSuccess: true);
      } else {
        // ignore: use_build_context_synchronously
        ToastService.show(context, 'Error: ${_loginResponse!.message}');
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();

      if (kDebugMode) {
        print('Error verifying OTP: $error');
      }
      // ignore: use_build_context_synchronously
      ToastService.show(context, 'Error verifying OTP');

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }



  Future<UserDetailsResponse> getUserInfo(
    String username,
    BuildContext context,
  ) async {
    try {
      print('Fetching user info...');
      // Step 1: Check for cached data in the database
      var userDetailsMap =
          await _userDatabase.getUserDetailsByUsername(username);
      _cachedResponse = UserDetailsResponse.fromJson(userDetailsMap ?? {});

      // if (!_isLoading) {
      //   print('Running API in the background');
      //   _isLoading = true;
      //   notifyListeners();
      //   _runApiInBackground(username);
      // }

      if (_cachedResponse.data != null) {
        // Use cached response
        print('Using cached response');
        _runApiInBackground(username);
        print('Call Background Response');
        return _cachedResponse;
      }

      bool isConnected = await _checkInternet();

      if (!isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No internet connection'),
            backgroundColor: Colors.red,
          ),
        );

        return UserDetailsResponse(
          success: false,
          message: 'No internet connection',
          data: null,
        );
      }

      Response response = await _dio.post(
        '${BaseURL.baseUrl}sf_user_info',
        queryParameters: {'username': username},
      );
      if (response.statusCode == 200 && response.data != null) {
        print('Successful Response');
        var responseData = response.data as Map<String, dynamic>;
        var userData = responseData['data'];
        _userDetails = UserDetails.fromJson(userData);
        print('Parsed user details: $_userDetails');

        // Log each field of the UserDetails before saving
        print('Emp Access Type: ${_userDetails?.accessType}');
        print('Emp Valid From: ${_userDetails?.validFrom}');
        print('Emp Valid To: ${_userDetails?.validTo}');
        print('Emp Status: ${_userDetails?.status}');
        print('Region: ${_userDetails?.region}');
        print('Place Code: ${_userDetails?.placeCode}');
        print('Company Code: ${_userDetails?.companyCode}');
        print('Company Name: ${_userDetails?.companyName}');
        print('Emp Status: ${_userDetails?.status}');
        await _userDatabase.saveUserDetails(username, response.data!);
        AuthState().setToken(
          _userDetails!.userType,
          _userDetails!.employeeCode,
          _userDetails!.employeeName,
          _userDetails!.accessType,
          _userDetails!.validFrom,
          _userDetails!.validTo,
          _userDetails!.status,
          _userDetails!.region,
          _userDetails!.placeCode,
          _userDetails!.companyCode,
          _userDetails!.companyName,
          _userDetails!.plant,
        );
        return UserDetailsResponse.fromJson(response.data);
      } else {
        print('Background Error Response: ${response.data}');
        return UserDetailsResponse(
          success: false,
          message: 'No internet connection',
          data: null,
        );
      }
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print('Error fetching user info: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching user info: $error'),
          backgroundColor: Colors.red,
        ),
      );
      return UserDetailsResponse(
        success: false,
        message: 'No internet connection',
        data: null,
      );
    }
  }

  Future<void> _runApiInBackground(String username) async {
    try {
      print('calllllling Background Response');
      bool isConnected = await _checkInternet();

      if (isConnected) {
        Response response = await _dio.post(
          '${BaseURL.baseUrl}sf_user_info',
          queryParameters: {'username': username},
        );
        if (response.statusCode == 200 && response.data != null) {
          print('Successful Background Response');
          var responseData = response.data as Map<String, dynamic>;
          var userData = responseData['data'];
          _userDetails = UserDetails.fromJson(userData);
          print('Data: $userData');
          print('Emp Access Type: ${_userDetails?.accessType}');
          print('Emp Valid From: ${_userDetails?.validFrom}');
          print('Emp Valid To: ${_userDetails?.validTo}');
          print('Emp Status: ${_userDetails?.status}');
          print('Region: ${_userDetails?.region}');
          print('Place Code: ${_userDetails?.placeCode}');
          print('Company Code: ${_userDetails?.companyCode}');
          print('Company Name: ${_userDetails?.companyName}');
          await _userDatabase.saveUserDetails(username, response.data!);
          AuthState().setToken(
            _userDetails!.userType,
            _userDetails!.employeeCode,
            _userDetails!.employeeName,
            _userDetails!.accessType,
            _userDetails!.validFrom,
            _userDetails!.validTo,
            _userDetails!.status,
            _userDetails!.region,
            _userDetails!.placeCode,
            _userDetails!.companyCode,
            _userDetails!.companyName,
            _userDetails!.plant,
          );
        } else {
          print('Background Error Response: ${response.data}');
        }
      }
    } catch (error) {
      print('Error running API in background: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
