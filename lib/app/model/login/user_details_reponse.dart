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

// class UserDetails {
//   final String workplaceCode;
//   final String workplaceName;
//   final String hrEmployeeCode;
//   final String employeeName;
//   final String fatherName;
//   final String designation;
//   final String dateOfJoining;
//   final String headquarter;
//   final String mobileNumber;
//   final String email;
//   final String company;
//   final String dateOfLeaving;
//   final String? staffType;
//   final String? workplaceStartDate;
//   final String? workplaceEndDate;
//   final String? grade;
//   final String? gradeStartDate;
//   final String? gradeEndDate;
//   final String? hqStartDate;
//   final String? hqEndDate;
//   final String? isActive;
//   final String deviceToken;

//   UserDetails({
//     required this.workplaceCode,
//     required this.workplaceName,
//     required this.hrEmployeeCode,
//     required this.employeeName,
//     required this.fatherName,
//     required this.designation,
//     required this.dateOfJoining,
//     required this.headquarter,
//     required this.mobileNumber,
//     required this.email,
//     required this.company,
//     required this.dateOfLeaving,
//     this.staffType,
//     this.workplaceStartDate,
//     this.workplaceEndDate,
//     this.grade,
//     this.gradeStartDate,
//     this.gradeEndDate,
//     this.hqStartDate,
//     this.hqEndDate,
//     this.isActive,
//     required this.deviceToken,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//       workplaceCode: json['workplace_code'] ?? '',
//       workplaceName: json['workplace_name'] ?? '',
//       hrEmployeeCode: json['hr_employee_code'] ?? '',
//       employeeName: json['employee_name'] ?? '',
//       fatherName: json['father_name'] ?? '',
//       designation: json['designation'] ?? '',
//       dateOfJoining: json['date_of_joining'] ?? '',
//       headquarter: json['headquarter'] ?? '',
//       mobileNumber: json['mobile_number'] ?? '',
//       email: json['email'] ?? '',
//       company: json['company'] ?? '',
//       dateOfLeaving: json['date_of_leaving'] ?? '',
//       workplaceStartDate: json['workplace_start_date'],
//       workplaceEndDate: json['workplace_end_date'],
//       staffType: json['staff_type'],
//       grade: json['grade'],
//       gradeStartDate: json['grade_start_date'],
//       gradeEndDate: json['grade_end_date'],
//       hqStartDate: json['hq_start_date'],
//       hqEndDate: json['hq_end_date'],
//       isActive: json['is_active'],
//       deviceToken: json['device_token'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'workplace_code': workplaceCode,
//       'hr_employee_code': hrEmployeeCode,
//       'employee_name': employeeName,
//       'father_name': fatherName,
//       'designation': designation,
//       'date_of_joining': dateOfJoining,
//       'headquarter': headquarter,
//       'mobile_number': mobileNumber,
//       'email': email,
//       'company': company,
//       'date_of_leaving': dateOfLeaving,
//       'workplace_start_date': workplaceStartDate,
//       'workplace_end_date': workplaceEndDate,
//       'grade': grade,
//       'staff_type': staffType,
//       'grade_start_date': gradeStartDate,
//       'grade_end_date': gradeEndDate,
//       'hq_start_date': hqStartDate,
//       'hq_end_date': hqEndDate,
//       'is_active': isActive,
//       'device_token': deviceToken,
//     };
//   }
// }

class UserDetails {
  final String workplaceCode;
  final String workplaceName;
  final String hrEmployeeCode;
  final String employeeName;
  final String fatherName;
  final String designation;
  final String dateOfJoining;
  final String headquarter;
  final String territoryCode;
  final String territoryName;
  final String mobileNumber;
  final String email;
  final String company;
  final String dateOfLeaving;
  final String? staffType;
  final String? workplaceStartDate;
  final String? workplaceEndDate;
  final String? grade;
  final String? gradeStartDate;
  final String? gradeEndDate;
  final String? hqStartDate;
  final String? hqEndDate;
  final String? isActive;
  final String deviceToken;
  final List<MappingInfo> mappingInfo;

  UserDetails({
    required this.workplaceCode,
    required this.workplaceName,
    required this.hrEmployeeCode,
    required this.employeeName,
    required this.fatherName,
    required this.designation,
    required this.dateOfJoining,
    required this.headquarter,
    required this.territoryCode,
    required this.territoryName,
    required this.mobileNumber,
    required this.email,
    required this.company,
    required this.dateOfLeaving,
    this.staffType,
    this.workplaceStartDate,
    this.workplaceEndDate,
    this.grade,
    this.gradeStartDate,
    this.gradeEndDate,
    this.hqStartDate,
    this.hqEndDate,
    this.isActive,
    required this.deviceToken,
    required this.mappingInfo,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      workplaceCode: json['workplace_code'] ?? '',
      workplaceName: json['workplace_name'] ?? '',
      hrEmployeeCode: json['hr_employee_code'] ?? '',
      employeeName: json['employee_name'] ?? '',
      fatherName: json['father_name'] ?? '',
      designation: json['designation'] ?? '',
      dateOfJoining: json['date_of_joining'] ?? '',
      headquarter: json['headquarter'] ?? '',
      territoryCode: json['territory_code'] ?? '',
      territoryName: json['territory_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      email: json['email'] ?? '',
      company: json['company'] ?? '',
      dateOfLeaving: json['date_of_leaving'] ?? '',
      workplaceStartDate: json['workplace_start_date'],
      workplaceEndDate: json['workplace_end_date'],
      staffType: json['staff_type'],
      grade: json['grade'],
      gradeStartDate: json['grade_start_date'],
      gradeEndDate: json['grade_end_date'],
      hqStartDate: json['hq_start_date'],
      hqEndDate: json['hq_end_date'],
      isActive: json['is_active'],
      deviceToken: json['device_token'] ?? '',
      mappingInfo: (json['mapping_info'] as List<dynamic>?)
              ?.map((e) => MappingInfo.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workplace_code': workplaceCode,
      'workplace_name': workplaceName,
      'hr_employee_code': hrEmployeeCode,
      'employee_name': employeeName,
      'father_name': fatherName,
      'designation': designation,
      'date_of_joining': dateOfJoining,
      'headquarter': headquarter,
      'territory_code': territoryCode,
      'territory_name': territoryName,
      'mobile_number': mobileNumber,
      'email': email,
      'company': company,
      'date_of_leaving': dateOfLeaving,
      'workplace_start_date': workplaceStartDate,
      'workplace_end_date': workplaceEndDate,
      'grade': grade,
      'staff_type': staffType,
      'grade_start_date': gradeStartDate,
      'grade_end_date': gradeEndDate,
      'hq_start_date': hqStartDate,
      'hq_end_date': hqEndDate,
      'is_active': isActive,
      'device_token': deviceToken,
      'mapping_info': mappingInfo.map((e) => e.toJson()).toList(),
    };
  }
}

class MappingInfo {
  final String userType;
  final String employeeCode;
  final String employeeName;

  MappingInfo({
    required this.userType,
    required this.employeeCode,
    required this.employeeName,
  });

  factory MappingInfo.fromJson(Map<String, dynamic> json) {
    return MappingInfo(
      userType: json['user_type'] ?? '',
      employeeCode: json['employee_code'] ?? '',
      employeeName: json['employee_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_type': userType,
      'employee_code': employeeCode,
      'employee_name': employeeName,
    };
  }
}

// class UserDetails {
//   final String userType;
//   final String companyCode;
//   final String email;
//   final String companyName;
//   final String employeeCode;
//   final String employeeName;
//   final String accessType;
//   final String validFrom;
//   final String validTo;
//   final String status;
//   final String region;
//   final String regionName;
//   final String placeCode;
//   final String grade;
//   final String hq;
//   final String hqName;
//   final String plant;
//   final String plantName;
//   final String territory;
//   final double hqLatitude;
//   final double hqLongitude;
//   //
//   final String workPlaceName;
//   final String workPlaceCode;
//   final String hqCode;
//   final String gradeName;
//   final String gradeCode;
//   final String territoryName;
//   final String territoryCode;
//   final String customerName;
//   final String customerCode;
//   final String villageName;
//   final String villageCode;
//   final String retailerName;
//   final String retailerCode;
//   final String mobileNumber;
//   final String emailAddress;
//   final String fatherName;
//   final String dateOfJoining;
//   final String dateOfLeaving;
//   final String staffType;
//   final bool isActive;
//   final String attendanceRecords;
//   final String tourPlan;
//   final String targetAchievements;

//   UserDetails({
//     required this.userType,
//     required this.companyCode,
//     required this.email,
//     required this.companyName,
//     required this.employeeCode,
//     required this.employeeName,
//     required this.accessType,
//     required this.validFrom,
//     required this.validTo,
//     required this.status,
//     required this.region,
//     required this.regionName,
//     required this.placeCode,
//     required this.grade,
//     required this.hq,
//     required this.hqName,
//     required this.plant,
//     required this.plantName,
//     required this.territory,
//     required this.hqLatitude,
//     required this.hqLongitude,
//     //
//     required this.workPlaceName,
//     required this.workPlaceCode,
//     required this.hqCode,
//     required this.gradeName,
//     required this.gradeCode,
//     required this.territoryName,
//     required this.territoryCode,
//     required this.customerName,
//     required this.customerCode,
//     required this.villageName,
//     required this.villageCode,
//     required this.retailerName,
//     required this.retailerCode,
//     required this.mobileNumber,
//     required this.emailAddress,
//     required this.fatherName,
//     required this.dateOfJoining,
//     required this.dateOfLeaving,
//     required this.staffType,
//     required this.isActive,
//     required this.attendanceRecords,
//     required this.tourPlan,
//     required this.targetAchievements,
//   });

//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return UserDetails(
//       userType: json['user_type'] ?? '',
//       companyCode: json['company_code'] ?? '',
//       email: json['email'] ?? '',
//       companyName: json['company_name'] ?? '',
//       employeeCode: json['employee_code'] ?? '',
//       employeeName: json['employee_name'] ?? '',
//       accessType: json['access_type'] ?? '',
//       validFrom: json['valid_from'] ?? '',
//       validTo: json['valid_to'] ?? '',
//       status: json['status'].toString(),
//       region: json['region'] ?? '',
//       regionName: json['region_name'] ?? '',
//       placeCode: json['place_code'] ?? '',
//       grade: json['grade'] ?? '',
//       hq: json['hq'] ?? '',
//       hqName: json['hq_name'] ?? '',
//       plant: json['plant'] ?? '',
//       plantName: json['plant_name'] ?? '',
//       territory: json['territory'] ?? '',
//       hqLatitude: (json['hq_latitude'] ?? '0.0') is double
//           ? json['hq_latitude']
//           : double.parse(json['hq_latitude'] ?? '0.0'),
//       hqLongitude: (json['hq_longitude'] ?? '0.0') is double
//           ? json['hq_longitude']
//           : double.parse(json['hq_longitude'] ?? '0.0'),
//       workPlaceName: json['work_place_name'] ?? '',
//       workPlaceCode: json['work_place_code'] ?? '',
//       hqCode: json['hq_code'] ?? '',
//       gradeName: json['grade_name'] ?? '',
//       gradeCode: json['grade_code'] ?? '',
//       territoryName: json['territory_name'] ?? '',
//       territoryCode: json['territory_code'] ?? '',
//       customerName: json['customer_name'] ?? '',
//       customerCode: json['customer_code'] ?? '',
//       villageName: json['village_name'] ?? '',
//       villageCode: json['village_code'] ?? '',
//       retailerName: json['retailer_name'] ?? '',
//       retailerCode: json['retailer_code'] ?? '',
//       mobileNumber: json['mobile_number'] ?? '',
//       emailAddress: json['email_address'] ?? '',
//       fatherName: json['father_name'] ?? '',
//       dateOfJoining: json['date_of_joining'] ?? '',
//       dateOfLeaving: json['date_of_leaving'] ?? '',
//       staffType: json['staff_type'] ?? '',
//       isActive: json['is_active'] ?? false,
//       attendanceRecords: json['attendance_records'] ?? '',
//       tourPlan: json['tour_plan'] ?? '',
//       targetAchievements: json['target_achievements'] ?? '',
//     );
//   }

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'user_type': userType,
// //       'company_code': companyCode,
// //       'company_name': companyName,
// //       'employee_code': employeeCode,
// //       'employee_name': employeeName,
// //       'access_type': accessType,
// //       'valid_from': validFrom,
// //       'valid_to': validTo,
// //       'status': status,
// //       'region': region,
// //       'region_name': regionName,
// //       'place_code': placeCode,
// //       'grade': grade,
// //       'hq': hq,
// //       'hq_name': hqName,
// //       'plant': plant,
// //       'plant_name': plantName,
// //       'territory': territory,
// //       'hq_latitude': hqLatitude,
// //       'hq_longitude': hqLongitude,
// //     };
// //   }
// // }
// Map<String, dynamic> toJson() {
//     return {
//       'user_type': userType,
//       'company_code': companyCode,
//       'company_name': companyName,
//       'employee_code': employeeCode,
//       'employee_name': employeeName,
//       'access_type': accessType,
//       'valid_from': validFrom,
//       'valid_to': validTo,
//       'status': status,
//       'region': region,
//       'region_name': regionName,
//       'place_code': placeCode,
//       'grade': grade,
//       'hq': hq,
//       'hq_name': hqName,
//       'plant': plant,
//       'plant_name': plantName,
//       'territory': territory,
//       'hq_latitude': hqLatitude,
//       'hq_longitude': hqLongitude,
//       'work_place_name': workPlaceName,
//       'work_place_code': workPlaceCode,
//       'hq_code': hqCode,
//       'grade_name': gradeName,
//       'grade_code': gradeCode,
//       'territory_name': territoryName,
//       'territory_code': territoryCode,
//       'customer_name': customerName,
//       'customer_code': customerCode,
//       'village_name': villageName,
//       'village_code': villageCode,
//       'retailer_name': retailerName,
//       'retailer_code': retailerCode,
//       'mobile_number': mobileNumber,
//       'email_address': emailAddress,
//       'father_name': fatherName,
//       'date_of_joining': dateOfJoining,
//       'date_of_leaving': dateOfLeaving,
//       'staff_type': staffType,
//       'is_active': isActive,
//       'attendance_records': attendanceRecords,
//       'tour_plan': tourPlan,
//       'target_achievements': targetAchievements,
//     };
//   }
// }
