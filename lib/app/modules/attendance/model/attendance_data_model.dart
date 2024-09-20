class AttendanceData {
  final int id;
  final String? checkinDate;
  final String? checkinTime;
  final String? checkoutDate;
  final String? checkoutTime;
  final String? checkinLat;
  final String? checkinLong;
  final String? checkoutLat;
  final String? checkoutLong;
  final List<AttendanceSummary> attendanceSummaries;

  AttendanceData({
    required this.id,
    this.checkinDate,
    this.checkinTime,
    this.checkoutDate,
    this.checkoutTime,
    this.checkinLat,
    this.checkinLong,
    this.checkoutLat,
    this.checkoutLong,
    required this.attendanceSummaries,
  });
  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    var summariesFromJson = json['attendance_summaries'] as List? ?? [];
    List<AttendanceSummary> summaries =
        summariesFromJson.map((i) => AttendanceSummary.fromJson(i)).toList();

    return AttendanceData(
      id: json['id'],
      checkinDate: json['checkin_date'] ?? '',
      checkinTime: json['checkin_time'] ?? '',
      checkoutDate: json['checkout_date'] ?? '',
      checkoutTime: json['checkout_time'] ?? '',
      checkinLat: json['checkin_lat'] ?? '',
      checkinLong: json['checkin_long'] ?? '',
      checkoutLat: json['checkout_lat'] ?? '',
      checkoutLong: json['checkout_long'] ?? '',
      attendanceSummaries: summaries,
    );
  }
}

class AttendanceSummary {
  final int id;
  final String latitude;
  final String longitude;
  final String date;
  final String time;

  AttendanceSummary({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.time,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSummary(
      id: json['id'],
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
