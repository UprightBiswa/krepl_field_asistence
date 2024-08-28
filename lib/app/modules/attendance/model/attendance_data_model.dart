class AttendanceData {
  final int id;
  final String? employeeCode;
  final String? dateOfAttendance;
  final String? checkinTime;
  final String? checkoutTime;
  final String? yearOfAttendance;
  final String? monthOfAttendance;
  final String? checkinLat;
  final String? checkinLong;
  final String? checkoutLat;
  final String? checkoutLong;
  final String? checkinLocation;
  final String? checkoutLocation;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? totalWorkingHours;

  AttendanceData({
    required this.id,
    this.employeeCode,
    this.dateOfAttendance,
    this.checkinTime,
    this.checkoutTime,
    this.yearOfAttendance,
    this.monthOfAttendance,
    this.checkinLat,
    this.checkinLong,
    this.checkoutLat,
    this.checkoutLong,
    this.checkinLocation,
    this.checkoutLocation,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.totalWorkingHours,
  });
}
