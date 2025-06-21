import '../../../model/master/villages_model.dart';
import 'tour_activity_type_model.dart';
import 'tour_route_master.dart';

class TourPlan {
  final int id;
  final String hremployeecode;
  final String employeename;
  final String tourDate;
  final List<String> villageNames;
  final List<String> routeNames;
  final List<String> activityNames;
  final List<Village> villages;
  final List<TourRouteMaster> routes;
  final List<TourActivity> activities;
  final String remarks;
  final String createdAt;
  final int status;

  TourPlan({
    required this.id,
    required this.hremployeecode,
    required this.employeename,
    required this.tourDate,
    required this.villageNames,
    required this.routeNames,
    required this.activityNames,
    required this.villages,
    required this.routes,
    required this.activities,
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
      villageNames: List<String>.from(json['village'] ?? []),
      routeNames: List<String>.from(json['route'] ?? []),
      activityNames: List<String>.from(json['activity'] ?? []),
      villages:
          (json['villages'] as List).map((e) => Village.fromJson(e)).toList(),
      routes: (json['routes'] as List)
          .map((e) => TourRouteMaster.fromJson(e))
          .toList(),
      activities: (json['activities'] as List)
          .map((e) => TourActivity.fromJson(e))
          .toList(),
      remarks: json['remarks'] ?? '',
      createdAt: json['created_at'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}
