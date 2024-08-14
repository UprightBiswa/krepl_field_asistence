
// ignore: constant_identifier_names
import '../../../model/employee/employee_model.dart';
import '../../../model/village/villages_model.dart';
import '../../../model/workplace/workplace_model.dart';

enum RouteStatus { Active, Deactive, Delete }

class RouteMap {
  final String routeNo;
  final String routeName;
   final List<Employee> employees; // Multiple employees
  final List<WorkPlace> workPlaces; // Multiple workplaces
  final List<Village> villages;
  final String stateName;
  final String districtName;
  final String subDistName;
  final String pincode;
  final String officeName;
  final DateTime fromDate;
  final DateTime toDate;
  final RouteStatus status;

  RouteMap({
    required this.routeNo,
    required this.routeName,
    required this.employees,
    required this.workPlaces,
    required this.villages,
    required this.stateName,
    required this.districtName,
    required this.subDistName,
    required this.pincode,
    required this.officeName,
    required this.fromDate,
    required this.toDate,
    required this.status,
  });
}


// Dummy RouteMaps
final List<RouteMap> dummyRouteData = [
  RouteMap(
    routeNo: "R001",
    routeName: "North Zone",
    employees: [employeesList[0], employeesList[1]],
    workPlaces: [workPlacesList[0], workPlacesList[1]],
    villages: [villagesList[0]],
    stateName: "State A",
    districtName: "District 1",
    subDistName: "Sub-district 1",
    pincode: "123456",
    officeName: "Branch Office",
    fromDate: DateTime(2024, 1, 1),
    toDate: DateTime(2024, 12, 31),
    status: RouteStatus.Active,
  ),
  RouteMap(
    routeNo: "R002",
    routeName: "South Zone",
    employees: [employeesList[1]],
    workPlaces: [workPlacesList[1], workPlacesList[2]],
    villages: [villagesList[1], villagesList[2]],
    stateName: "State B",
    districtName: "District 2",
    subDistName: "Sub-district 2",
    pincode: "654321",
    officeName: "Sub Office",
    fromDate: DateTime(2024, 2, 1),
    toDate: DateTime(2024, 11, 30),
    status: RouteStatus.Deactive,
  ),
  RouteMap(
    routeNo: "R003",
    routeName: "East Zone",
    employees: [employeesList[2], employeesList[0]],
    workPlaces: [workPlacesList[2], workPlacesList[0]],
    villages: [villagesList[2],villagesList[1]],
    stateName: "State C",
    districtName: "District 3",
    subDistName: "Sub-district 3",
    pincode: "789012",
    officeName: "Head Office",
    fromDate: DateTime(2024, 3, 1),
    toDate: DateTime(2024, 10, 31),
    status: RouteStatus.Delete,
  ),
];