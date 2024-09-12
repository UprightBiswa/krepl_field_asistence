import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/attendance_data_model.dart';
import '../model/today_status_model.dart';

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

      // Define endpoint and send request
      String endPoint = 'fetchTodaysFaAttendance';
      final response = await _dioService.post(endPoint);

      // Handle successful response
      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        todayStatus.value = TodayStatus.fromJson(data);
      }
      // Handle unsuccessful response
      else if (response.data['success'] == false) {
        String errorMsg = response.data['message']['device_token']?.first ??
            'Error fetching attendance';
        errorMessage(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
      print("Error fetching today's status: $e");
    } finally {
      isLoading(false);
    }
  }
}
