class TourPlan {
  final int id;
  final String hremployeecode;
  final String employeename;
  final String tourDate;
  final List<String> village;
  final List<String> route;
  final List<String> activity;
  final String remarks;
  final String createdAt;
  final int status;

  TourPlan({
    required this.id,
    required this.hremployeecode,
    required this.employeename,
    required this.tourDate,
    required this.village,
    required this.route,
    required this.activity,
    required this.remarks,
    required this.createdAt,
    required this.status,
  });

  factory TourPlan.fromJson(Map<String, dynamic> json) {
    return TourPlan(
      id: json['id'],
      hremployeecode: json['hr_employee_code'] ?? '',
      employeename: json['employee_name'] ?? '',
      tourDate: json['tour_date'] ?? '',
      village: List<String>.from(json['village'] ?? []),
      route: List<String>.from(json['route'] ?? []),
      activity: List<String>.from(json['activity'] ?? []),
      remarks: json['remarks'] ?? '',
      createdAt: json['created_at'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}
