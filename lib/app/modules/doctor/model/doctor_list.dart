// models/doctor.dart
class Doctor {
  final int id;
  final String name;
  final String fatherName;
  final String mobileNumber;
  final String acre;
  final String pinCode;
  final String?
      villageName; // Nullable because it might be null in the response
  final String postOfficeName;
  final String subDistName;
  final String districtName;
  final String stateName;
  final String workPlaceCode;
  final String workPlaceName;

  Doctor({
    required this.id,
    required this.name,
    required this.fatherName,
    required this.mobileNumber,
    required this.acre,
    required this.pinCode,
    this.villageName, // Nullable field
    required this.postOfficeName,
    required this.subDistName,
    required this.districtName,
    required this.stateName,
    required this.workPlaceCode,
    required this.workPlaceName,
  });

  // Convert JSON response to Doctor object
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['doctor_name'],
      fatherName: json['doctor_father_name'],
      mobileNumber: json['mobile_no'],
      acre: json['acre'],
      pinCode: json['pin'],
      villageName: json['village_name'],
      postOfficeName: json['officename'],
      subDistName: json['tehshil'],
      districtName: json['district'],
      stateName: json['state'],
      workPlaceCode: json['workplace_code'],
      workPlaceName: json['workplace_name'],
    );
  }
}
