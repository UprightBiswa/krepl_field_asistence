class UserDetailsResponse {
  final bool success;
  final String message;
  final UserDetails? data;

  UserDetailsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserDetails.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class UserDetails {
  final String userType;
  final String companyCode;
  final String email;
  final String companyName;
  final String employeeCode;
  final String employeeName;
  final String accessType;
  final String validFrom;
  final String validTo;
  final String status;
  final String region;
  final String regionName;
  final String placeCode;
  final String grade;
  final String hq;
  final String hqName;
  final String plant;
  final String plantName;
  final String territory;
  final double hqLatitude;
  final double hqLongitude;

  UserDetails({
    required this.userType,
    required this.companyCode,
    required this.email,
    required this.companyName,
    required this.employeeCode,
    required this.employeeName,
    required this.accessType,
    required this.validFrom,
    required this.validTo,
    required this.status,
    required this.region,
    required this.regionName,
    required this.placeCode,
    required this.grade,
    required this.hq,
    required this.hqName,
    required this.plant,
    required this.plantName,
    required this.territory,
    required this.hqLatitude,
    required this.hqLongitude,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userType: json['user_type'] ?? '',
      companyCode: json['company_code'] ?? '',
      email: json['email'] ?? '',
      companyName: json['company_name'] ?? '',
      employeeCode: json['employee_code'] ?? '',
      employeeName: json['employee_name'] ?? '',
      accessType: json['access_type'] ?? '',
      validFrom: json['valid_from'] ?? '',
      validTo: json['valid_to'] ?? '',
      status: json['status'].toString(),
      region: json['region'] ?? '',
      regionName: json['region_name'] ?? '',
      placeCode: json['place_code'] ?? '',
      grade: json['grade'] ?? '',
      hq: json['hq'] ?? '',
      hqName: json['hq_name'] ?? '',
      plant: json['plant'] ?? '',
      plantName: json['plant_name'] ?? '',
      territory: json['territory'] ?? '',
      hqLatitude: (json['hq_latitude'] ?? '0.0') is double
          ? json['hq_latitude']
          : double.parse(json['hq_latitude'] ?? '0.0'),
      hqLongitude: (json['hq_longitude'] ?? '0.0') is double
          ? json['hq_longitude']
          : double.parse(json['hq_longitude'] ?? '0.0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_type': userType,
      'company_code': companyCode,
      'company_name': companyName,
      'employee_code': employeeCode,
      'employee_name': employeeName,
      'access_type': accessType,
      'valid_from': validFrom,
      'valid_to': validTo,
      'status': status,
      'region': region,
      'region_name': regionName,
      'place_code': placeCode,
      'grade': grade,
      'hq': hq,
      'hq_name': hqName,
      'plant': plant,
      'plant_name': plantName,
      'territory': territory,
      'hq_latitude': hqLatitude,
      'hq_longitude': hqLongitude,
    };
  }
}
