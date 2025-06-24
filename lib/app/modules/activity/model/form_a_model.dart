class FormAModel {
  String formName; // Form name or identifier
  String promotionalActivitiesType;
  String partyType;
  String mobileNumber;
  String farmerVillageDoctorName;
  String season;
  String crop;
  String cropStage;
  String product;
  String pest;
  int totalNumberFarmerVillageDoctor;
  double expense; // Assuming expense is a numeric field
  bool photoRequired;
  bool jioLocationTickRequired;
  String
      updateMobileNumber; // Assuming it's a string if it involves updating a mobile number
  String remark;

  FormAModel({
    required this.formName,
    required this.promotionalActivitiesType,
    required this.partyType,
    required this.mobileNumber,
    required this.farmerVillageDoctorName,
    required this.season,
    required this.crop,
    required this.cropStage,
    required this.product,
    required this.pest,
    required this.totalNumberFarmerVillageDoctor,
    required this.expense,
    required this.photoRequired,
    required this.jioLocationTickRequired,
    required this.updateMobileNumber,
    required this.remark,
  });
}

// class FormA {
//   final int id;
//   final String promotionActivityType;
//   final String partyType;
//   final String latitude;
//   final String longitude;
//   final String remarks;
//   final int totalPartyNo;
//   final String imageUrl;
//   final String createdAt;
//   final List<FormADetails> formADetails;
//   final List<FormAUserDetails> formAUserDetails;

//   FormA({
//     required this.id,
//     required this.promotionActivityType,
//     required this.partyType,
//     required this.latitude,
//     required this.longitude,
//     required this.remarks,
//     required this.totalPartyNo,
//     required this.imageUrl,
//     required this.createdAt,
//     required this.formADetails,
//     required this.formAUserDetails,
//   });

//   factory FormA.fromJson(Map<String, dynamic> json) {
//     return FormA(
//       id: json['id'],
//       promotionActivityType: json['promotion_activity_type'] ?? '',
//       partyType: json['party_type'] ?? '',
//       latitude: json['latitude'] ?? '',
//       longitude: json['longitude'] ?? '',
//       remarks: json['remarks'] ?? '',
//       totalPartyNo: json['total_party_no'] ?? '',
//       imageUrl: json['imageUrl'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       formADetails: (json['formADetails'] as List)
//           .map((item) => FormADetails.fromJson(item))
//           .toList(),
//       formAUserDetails: (json['formAUserDetails'] as List)
//           .map((item) => FormAUserDetails.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class FormADetails {
//   final int id;
//   final String cropName;
//   final String cropStageName;
//   final String productName;
//   final String pestName;
//   final String expense;
//   final String seasonName;

//   FormADetails({
//     required this.id,
//     required this.cropName,
//     required this.cropStageName,
//     required this.productName,
//     required this.pestName,
//     required this.expense,
//     required this.seasonName,
//   });

//   factory FormADetails.fromJson(Map<String, dynamic> json) {
//     return FormADetails(
//       id: json['id'],
//       cropName: json['crop_name'] ?? '',
//       cropStageName: json['crop_stage_name'] ?? '',
//       productName: json['product_name'] ?? '',
//       pestName: json['pest_name'] ?? '',
//       expense: json['expense'] ?? '',
//       seasonName: json['season_name'] ?? '',
//     );
//   }
// }

// class FormAUserDetails {
//   final int id;
//   final String partyName;
//   final String mobileNo;

//   FormAUserDetails({
//     required this.id,
//     required this.partyName,
//     required this.mobileNo,
//   });

//   factory FormAUserDetails.fromJson(Map<String, dynamic> json) {
//     return FormAUserDetails(
//       id: json['id'],
//       partyName: json['party_name'] ?? '',
//       mobileNo: json['mobile_no'] ?? '',
//     );
//   }
// }

class FormA {
  final int id;
  final String promotionActivityType;
  final String partyType;
  final String latitude;
  final String longitude;
  final String totalKmTravelled;
  final String remarks;
  final String expense;
  final String activityPerformedLocation;
  final String activityPerformedDate;
  final int totalPartyNo;
  final String imageUrl;
  final String createdAt;
  final List<String> seasonDetails;
  final List<String> productDetails;
  final List<String> cropDetails;
  final List<String> cropStageDetails;
  final List<String> pestDetails;
  final List<FormAUserDetails> formAUserDetails;

  FormA({
    required this.id,
    required this.promotionActivityType,
    required this.partyType,
    required this.latitude,
    required this.longitude,
    required this.remarks,
    required this.totalKmTravelled,
    required this.expense,
    required this.activityPerformedLocation,
    required this.activityPerformedDate,
    required this.totalPartyNo,
    required this.imageUrl,
    required this.createdAt,
    required this.seasonDetails,
    required this.productDetails,
    required this.cropDetails,
    required this.cropStageDetails,
    required this.pestDetails,
    required this.formAUserDetails,
  });

  factory FormA.fromJson(Map<String, dynamic> json) {
    return FormA(
      id: json['id'],
      promotionActivityType: json['promotion_activity_type'] ?? '',
      partyType: json['party_type'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      remarks: json['remarks'] ?? '',
      totalKmTravelled: json['total_km_travelled'] ?? '',
      expense: json['expense'] ?? '',
      activityPerformedLocation: json['activity_performed_location'] ?? '',
      activityPerformedDate: json['activity_performed_date'] ?? '',
      totalPartyNo: json['total_party_no'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      seasonDetails: List<String>.from(json['season_details'] ?? []),
      productDetails: List<String>.from(json['product_details'] ?? []),
      cropDetails: List<String>.from(json['crop_details'] ?? []),
      cropStageDetails: List<String>.from(json['crop_stage_details'] ?? []),
      pestDetails: List<String>.from(json['pest_details'] ?? []),
      formAUserDetails: (json['formAUserDetails'] as List<dynamic>?)
              ?.map((item) => FormAUserDetails.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class FormAUserDetails {
  final int id;
  final String partyName;
  final String mobileNo;

  FormAUserDetails({
    required this.id,
    required this.partyName,
    required this.mobileNo,
  });

  factory FormAUserDetails.fromJson(Map<String, dynamic> json) {
    return FormAUserDetails(
      id: json['id'],
      partyName: json['party_name'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
    );
  }
}
