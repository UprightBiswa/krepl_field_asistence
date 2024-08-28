import 'package:get/get.dart';

import '../model/attendance_data_model.dart';
import '../model/today_status_model.dart';

List<AttendanceData> dummyAttendanceData = [
  AttendanceData(
    id: 1,
    employeeCode: "EMP001",
    dateOfAttendance: "2024-08-01",
    checkinTime: "09:00 AM",
    checkoutTime: "05:00 PM",
    yearOfAttendance: "2024",
    monthOfAttendance: "08",
    checkinLat: "28.7041",
    checkinLong: "77.1025",
    checkoutLat: "28.7041",
    checkoutLong: "77.1025",
    checkinLocation: "Office",
    checkoutLocation: "Office",
    createdAt: "2024-08-01T09:00:00Z",
    updatedAt: "2024-08-01T17:00:00Z",
    deletedAt: null,
    totalWorkingHours: "8 hours",
  ),
  AttendanceData(
    id: 2,
    employeeCode: "EMP001",
    dateOfAttendance: "2024-08-02",
    checkinTime: "09:30 AM",
    checkoutTime: "05:30 PM",
    yearOfAttendance: "2024",
    monthOfAttendance: "08",
    checkinLat: "28.7041",
    checkinLong: "77.1025",
    checkoutLat: "28.7041",
    checkoutLong: "77.1025",
    checkinLocation: "Office",
    checkoutLocation: "Office",
    createdAt: "2024-08-02T09:30:00Z",
    updatedAt: "2024-08-02T17:30:00Z",
    deletedAt: null,
    totalWorkingHours: "8 hours",
  ),
  AttendanceData(
    id: 3,
    employeeCode: "EMP001",
    dateOfAttendance: "2024-08-03",
    checkinTime: "09:15 AM",
    checkoutTime: "05:15 PM",
    yearOfAttendance: "2024",
    monthOfAttendance: "08",
    checkinLat: "28.7041",
    checkinLong: "77.1025",
    checkoutLat: "28.7041",
    checkoutLong: "77.1025",
    checkinLocation: "Office",
    checkoutLocation: "Office",
    createdAt: "2024-08-03T09:15:00Z",
    updatedAt: "2024-08-03T17:15:00Z",
    deletedAt: null,
    totalWorkingHours: "8 hours",
  ),
  // Add more dummy data as needed
];

TodayStatus dummyTodayStatus = TodayStatus(
  checkinTime: "09:15 AM",
  checkoutTime: null,
  isCheckedIn: true,
  isCheckedOut: false,
);

class AttendanceController extends GetxController {
  var attendanceList = <AttendanceData>[].obs;
  var todayStatus = TodayStatus().obs;
  var isLoading = false.obs;
  var isError = false.obs;

  Future<void> fetchAttendance({
    required String employeeCode,
    required String month,
    required String year,
  }) async {
    try {
      isLoading(true);
      await Future.delayed(
          const Duration(seconds: 2)); // Simulating network call

      // Filter and load the attendance data
      List<AttendanceData> filteredData =
          dummyAttendanceData.where((attendance) {
        return attendance.employeeCode == employeeCode &&
            attendance.monthOfAttendance == month &&
            attendance.yearOfAttendance == year;
      }).toList();

      attendanceList.assignAll(filteredData);
      isError(false);
    } catch (e) {
      isError(true);
      print("Error fetching attendance: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTodayStatus({required String employeeCode}) async {
    try {
      isLoading(true);
      await Future.delayed(
          const Duration(seconds: 1)); // Simulating network call

      // Fetch today's attendance data from the list (for simplicity)
      AttendanceData? todayData = dummyAttendanceData.firstWhere(
        (attendance) =>
            attendance.employeeCode == employeeCode &&
            attendance.dateOfAttendance ==
                DateTime.now().toString().split(' ')[0],
        orElse: () => AttendanceData(id: -1),
      );

      if (todayData.id != -1) {
        todayStatus.value = TodayStatus(
          checkinTime: todayData.checkinTime,
          checkoutTime: todayData.checkoutTime,
          isCheckedIn: todayData.checkinTime != null,
          isCheckedOut: todayData.checkoutTime != null,
        );
      } else {
        todayStatus.value =
            TodayStatus(isCheckedIn: false, isCheckedOut: false);
      }
      isError(false);
    } catch (e) {
      isError(true);
      print("Error fetching today's status: $e");
    } finally {
      isLoading(false);
    }
  }

  List<AttendanceData> filterAttendanceByDateRange(
      DateTime startDate, DateTime endDate) {
    return attendanceList.where((attendance) {
      DateTime date = DateTime.parse(attendance.dateOfAttendance ?? '');
      return date.isAfter(startDate) && date.isBefore(endDate);
    }).toList();
  }
}
