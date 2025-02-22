// // form_d_model.dart
// class FormD {
//   final int id;
//   final String promotionActivityType;
//   final String partyType;
//   final String latitude;
//   final String longitude;
//   final String remarks;
//   final String nextDemoDate;
//   final int totalPartyNo;
//   final String imageUrl;
//   final String createdAt;
//   final List<FormDDetails> formDDetails;
//   final List<FormDUserDetails> formDUserDetails;

//   FormD({
//     required this.id,
//     required this.promotionActivityType,
//     required this.partyType,
//     required this.latitude,
//     required this.longitude,
//     required this.remarks,
//     required this.nextDemoDate,
//     required this.totalPartyNo,
//     required this.imageUrl,
//     required this.createdAt,
//     required this.formDDetails,
//     required this.formDUserDetails,
//   });

//   factory FormD.fromJson(Map<String, dynamic> json) {
//     return FormD(
//       id: json['id'],
//       promotionActivityType: json['promotion_activity_type'],
//       partyType: json['party_type'],
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       remarks: json['remarks'] ?? '',
//       nextDemoDate: json['next_demo_date'],
//       totalPartyNo: json['total_party_no'],
//       imageUrl: json['imageUrl'] ?? '',
//       createdAt: json['createdAt'],
//       formDDetails: (json['formDDetails'] as List)
//           .map((item) => FormDDetails.fromJson(item))
//           .toList(),
//       formDUserDetails: (json['formDUserDetails'] as List)
//           .map((item) => FormDUserDetails.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class FormDDetails {
//   final int id;
//   final String cropName;
//   final String cropStageName;
//   final String productName;
//   final String pestName;
//   final String demoStatus;
//   final String seasonName;
//   final String? dosage;
//   final String? areaofdemo;
//   final String? totalarea;
//   final String? expense;

//   FormDDetails({
//     required this.id,
//     required this.cropName,
//     required this.cropStageName,
//     required this.productName,
//     required this.pestName,
//     required this.demoStatus,
//     required this.seasonName,
//     this.dosage,
//     this.areaofdemo,
//     this.totalarea,
//     this.expense,

//   });

//   factory FormDDetails.fromJson(Map<String, dynamic> json) {
//     return FormDDetails(
//       id: json['id'],
//       cropName: json['crop_name'],
//       cropStageName: json['crop_stage_name'],
//       productName: json['product_name'],
//       pestName: json['pest_name'],
//       demoStatus: json['demo_status'],
//       seasonName: json['season_name'],
//       dosage: json['dosage'],
//       areaofdemo: json['areaofdemo'],
//       totalarea: json['totalarea'],
//       expense: json['expense'],
//     );
//   }
// }

// class FormDUserDetails {
//   final int id;
//   final String partyName;
//   final String mobileNo;

//   FormDUserDetails({
//     required this.id,
//     required this.partyName,
//     required this.mobileNo,
//   });

//   factory FormDUserDetails.fromJson(Map<String, dynamic> json) {
//     return FormDUserDetails(
//       id: json['id'],
//       partyName: json['party_name'],
//       mobileNo: json['mobile_no'],
//     );
//   }
// }
class FormD {
  final int id;
  final String promotionActivityType;
  final String partyType;
  final String latitude;
  final String longitude;
  final String remarks;
  final String expense;
  final String totalAreaCover;
  final String areaOfDemo;
  final String dosages;
  final String activityPerformedLocation;
  final String activityPerformedDate;
  final String nextDemoDate;
  final int totalPartyNo;
  final String imageUrl;
  final String createdAt;
  final List<String> seasonDetails;
  final List<String> productDetails;
  final List<String> cropDetails;
  final List<String> cropStageDetails;
  final List<String> pestDetails;
  final List<String> demoStatusDetails;
  final List<String> resultDetails;
  final List<FormDUserDetails> formDUserDetails;

  FormD({
    required this.id,
    required this.promotionActivityType,
    required this.partyType,
    required this.latitude,
    required this.longitude,
    required this.totalAreaCover,
    required this.areaOfDemo,
    required this.dosages,
    required this.remarks,
    required this.expense,
    required this.activityPerformedLocation,
    required this.activityPerformedDate,
    required this.nextDemoDate,
    required this.totalPartyNo,
    required this.imageUrl,
    required this.createdAt,
    required this.seasonDetails,
    required this.productDetails,
    required this.cropDetails,
    required this.cropStageDetails,
    required this.pestDetails,
    required this.demoStatusDetails,
    required this.resultDetails,
    required this.formDUserDetails,
  });

  factory FormD.fromJson(Map<String, dynamic> json) {
    return FormD(
      id: json['id'],
      promotionActivityType: json['promotion_activity_type'],
      partyType: json['party_type'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      remarks: json['remarks'] ?? '',
      totalAreaCover: json['total_area_cover'],
      areaOfDemo: json['area_of_demo'],
      dosages: json['dosages'],
      expense: json['expense'],
      activityPerformedLocation: json['activity_performed_location'] ?? '',
      activityPerformedDate: json['activity_performed_date'],
      nextDemoDate: json['next_demo_date'],
      totalPartyNo: json['total_party_no'],
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'],
      seasonDetails: List<String>.from(json['season_details'] ?? []),
      productDetails: List<String>.from(json['product_details'] ?? []),
      cropDetails: List<String>.from(json['crop_details'] ?? []),
      cropStageDetails: List<String>.from(json['crop_stage_details'] ?? []),
      pestDetails: List<String>.from(json['pest_details'] ?? []),
      demoStatusDetails: List<String>.from(json['demo_status_details'] ?? []),
      resultDetails: List<String>.from(json['result_details'] ?? []),
      formDUserDetails: (json['formDUserDetails'] as List)
          .map((item) => FormDUserDetails.fromJson(item))
          .toList(),
    );
  }
}

class FormDUserDetails {
  final int id;
  final String partyName;
  final String mobileNo;

  FormDUserDetails({
    required this.id,
    required this.partyName,
    required this.mobileNo,
  });

  factory FormDUserDetails.fromJson(Map<String, dynamic> json) {
    return FormDUserDetails(
      id: json['id'],
      partyName: json['party_name'],
      mobileNo: json['mobile_no'],
    );
  }
}
