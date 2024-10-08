import 'package:dio/dio.dart' as dio;

import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/attendance_data_model.dart';
import '../model/today_status_model.dart';
import 'location_controller.dart';

class AttendanceController extends GetxController {
  var attendanceList = <AttendanceData>[].obs;
  var isLodaingList = false.obs;
  var isErrorList = false.obs;
  var errorMessageList = ''.obs;

  var todayStatus = TodayStatus().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();
  final LocationServiceController _locationServiceController =
      Get.put(LocationServiceController());
  Future<void> fetchAttendance({
    required String month,
    required String year,
  }) async {
    print(month + ' ' + year);
    try {
      isLodaingList(true);
      isErrorList(false);
      errorMessageList('');

      // Check for internet connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Define endpoint and send request
      String endPoint = 'fetchFaAttendanceByMonth';
      Map<String, dynamic> parameters = {
        'month': month,
        'year': year,
      };

      final response =
          await _dioService.post(endPoint, queryParams: parameters);
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'] as List;
        print(response.data);
        attendanceList.assignAll(
            data.map((json) => AttendanceData.fromJson(json)).toList());
      } else {
        print(response.data);
        String errorMsg =
            response.data['message'] ?? 'Error fetching attendance';
        errorMessageList(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      isErrorList(true);
      errorMessageList(e.toString());
      print("Error fetching attendance: $e");
    } finally {
      isLodaingList(false);
    }
  }

  Future<void> fetchTodayStatus() async {
    try {
      isLoading(true);
      isError(false);
      errorMessage('');

      // Check for internet connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Clear the current status to indicate a fresh load
      todayStatus.value = TodayStatus();

      // Define endpoint and send request
      String endPoint = 'fetchTodaysFaAttendance';
      final response = await _dioService.post(endPoint);

      // Handle successful response
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        todayStatus.value = TodayStatus.fromJson(data);
        // If the user is checked in but not checked out, start the location service
        if (todayStatus.value.isCheckedIn && !todayStatus.value.isCheckedOut) {
          if (!_locationServiceController.isTracking.value) {
            _locationServiceController.clearLocationData();
            // Start the location service if it's not already running
            _locationServiceController.startService();
          }
        }

        // If the user is checked out, stop the location service
        if (todayStatus.value.isCheckedOut) {
          if (_locationServiceController.isTracking.value) {
            // Stop the location service if it's still running
            _locationServiceController.stopService();
            _locationServiceController.clearLocationData();
          }
        }
      }
      // Handle unsuccessful response
      else if (response.data['success'] == false) {
        dynamic message = response.data['message'];

        // Check if message is a string or a map
        if (message is String) {
          errorMessage(message);
          throw Exception(message);
        } else if (message is Map && message.containsKey('device_token')) {
          String errorMsg =
              message['device_token']?.first ?? 'Error fetching attendance';
          errorMessage(errorMsg);
          throw Exception(errorMsg);
        } else {
          errorMessage('Unknown error occurred');
          throw Exception('Unknown error occurred');
        }
      }
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
      print("Error fetching today's status: $e");
    } finally {
      isLoading(false);
    }
  }

  //update attendance
  var isLoadingUpdate = false.obs;
  var isErrorUpdate = false.obs;
  var errorMessageUpdate = ''.obs;
  var isSuccessUpdate = false.obs;

  Future<void> updateCheckInAttendance({
    required String checkinDate,
    required String checkinTime,
    required String checkinLat,
    required String checkinLong,
  }) async {
    print(checkinDate);
    print(checkinTime);
    print(checkinLat);
    print(checkinLong);
    try {
      isLoadingUpdate(true);
      isErrorUpdate(false);
      errorMessageUpdate('');
      isSuccessUpdate(false);

      // Check for internet connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Define endpoint and send request
      String endPoint = 'fa_attandence';
      Map<String, dynamic> parameters = {
        'checkin_date': checkinDate,
        'checkin_time': checkinTime,
        'checkin_lat': checkinLat,
        'checkin_long': checkinLong,
        'status': '0',
      };

      final response =
          await _dioService.post(endPoint, queryParams: parameters);
      if (response.data['success'] == true) {
        print(response.data);
        isSuccessUpdate(true);
      } else {
        print(response.data);
        String errorMsg =
            response.data['message'] ?? 'You have already checked in.';
        errorMessageUpdate(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      isErrorUpdate(true);
      errorMessageUpdate(e.toString());
      print("Error updating attendance: $e");
    } finally {
      isLoadingUpdate(false);
    }
  }

  //checkOut of attendance
  var isLoadingCheckOut = false.obs;
  var isErrorCheckOut = false.obs;
  var errorMessageCheckOut = ''.obs;
  var isSuccessCheckOut = false.obs;

  Future<void> updateCheckOutAttendance({
    required String checkoutDate,
    required String checkoutTime,
    required String checkoutLat,
    required String checkoutLong,
    required List<Map<String, dynamic>> coordinates,
  }) async {
    print(checkoutDate);
    print(checkoutTime);
    print(checkoutLat);
    print(checkoutLong);
    print(coordinates);
    try {
      isLoadingCheckOut(true);
      isErrorCheckOut(false);
      errorMessageCheckOut('');
      isSuccessCheckOut(false);

      // Check for internet connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Define endpoint and send request
      String endPoint = 'fa_attandence';
      dio.FormData formData = dio.FormData.fromMap({
        'checkout_date': checkoutDate,
        'checkout_time': checkoutTime,
        'checkout_lat': checkoutLat,
        'checkout_long': checkoutLong,
        'status': 1,
        'coordinates': coordinates,
      });
      final response = await _dioService.postFormData(endPoint, formData);
      if (response.statusCode == 200 && response.data['success'] == true) {
        print(response.data);
        isSuccessCheckOut(true);
      } else {
        print(response.data);
        String errorMsg =
            response.data['message'] ?? 'Error updating attendance';
        errorMessageCheckOut(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      isErrorCheckOut(true);
      errorMessageCheckOut(e.toString());
      print("Error updating attendance: $e");
    } finally {
      isLoadingCheckOut(false);
    }
  }
}
