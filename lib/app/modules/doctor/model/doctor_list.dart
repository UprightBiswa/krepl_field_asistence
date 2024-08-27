// models/doctor.dart
class Doctor {
  final String name;
  final String fatherName;
  String mobileNumber;
  String acre;
  String pinCode;
  String villageLocalityName;
  String postOfficeName;
  String subDistName;
  String districtName;
  String stateName;
  String workPlaceCode;
  String workPlaceName;

  Doctor({
    required this.name,
    required this.fatherName,
    required this.mobileNumber,
    required this.acre,
    required this.pinCode,
    required this.villageLocalityName,
    required this.postOfficeName,
    required this.subDistName,
    required this.districtName,
    required this.stateName,
    required this.workPlaceCode,
    required this.workPlaceName,
  });
}
