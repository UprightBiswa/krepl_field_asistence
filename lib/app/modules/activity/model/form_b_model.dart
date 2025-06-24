// class FormB {
//   final int id;
//   final String promotionActivityType;
//   final String partyType;
//   final String? remarks;
//   final int totalPartyNo;
//   final String createdAt;
//   final List<FormBDetails> formBDetails;
//   final List<FormBUserDetails> formBUserDetails;

//   FormB({
//     required this.id,
//     required this.promotionActivityType,
//     required this.partyType,
//     this.remarks,
//     required this.totalPartyNo,
//     required this.createdAt,
//     required this.formBDetails,
//     required this.formBUserDetails,
//   });

//   factory FormB.fromJson(Map<String, dynamic> json) {
//     return FormB(
//       id: json['id'],
//       promotionActivityType: json['promotion_activity_type'],
//       partyType: json['party_type'],
//       remarks: json['remarks'],
//       totalPartyNo: json['total_party_no'],
//       createdAt: json['createdAt'],
//       formBDetails: (json['formBDetails'] as List)
//           .map((item) => FormBDetails.fromJson(item))
//           .toList(),
//       formBUserDetails: (json['formBUserDetails'] as List)
//           .map((item) => FormBUserDetails.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class FormBDetails {
//   final int id;
//   final String cropName;
//   final String cropStageName;
//   final String productName;
//   final String pestName;
//   final String seasonName;

//   FormBDetails({
//     required this.id,
//     required this.cropName,
//     required this.cropStageName,
//     required this.productName,
//     required this.pestName,
//     required this.seasonName,
//   });

//   factory FormBDetails.fromJson(Map<String, dynamic> json) {
//     return FormBDetails(
//       id: json['id'],
//       cropName: json['crop_name'],
//       cropStageName: json['crop_stage_name'],
//       productName: json['product_name'],
//       pestName: json['pest_name'],
//       seasonName: json['season_name'],
//     );
//   }
// }

// class FormBUserDetails {
//   final int id;
//   final String partyName;
//   final String routeName;
//   final String mobileNo;

//   FormBUserDetails({
//     required this.id,
//     required this.partyName,
//     required this.routeName,
//     required this.mobileNo,
//   });

//   factory FormBUserDetails.fromJson(Map<String, dynamic> json) {
//     return FormBUserDetails(
//       id: json['id'],
//       partyName: json['party_name'],
//       routeName: json['route_name'],
//       mobileNo: json['mobile_no'],
//     );
//   }
// }

class FormB {
  final int id;
  final String promotionActivityType;
  final String partyType;
  final String remarks;
  final String totalKmTravelled;

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
  // route_details
  final List<String> routeDetails;
  final List<FormBUserDetails> formBUserDetails;

  FormB({
    required this.id,
    required this.promotionActivityType,
    required this.partyType,
    required this.remarks,
    required this.totalKmTravelled,
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
    required this.routeDetails,
    required this.formBUserDetails,
  });

  factory FormB.fromJson(Map<String, dynamic> json) {
    return FormB(
      id: json['id'],
      promotionActivityType: json['promotion_activity_type'],
      partyType: json['party_type'],
      remarks: json['remarks'] ?? '',
      totalKmTravelled: json['total_km_travelled'] ?? '',
      activityPerformedLocation: json['activity_performed_location'],
      activityPerformedDate: json['activity_performed_date'],
      totalPartyNo: json['total_party_no'],
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'],
      seasonDetails: List<String>.from(json['season_details']),
      productDetails: List<String>.from(json['product_details']),
      cropDetails: List<String>.from(json['crop_details']),
      cropStageDetails: List<String>.from(json['crop_stage_details']),
      pestDetails: List<String>.from(json['pest_details']),
      routeDetails: List<String>.from(json['route_details']),
      formBUserDetails: (json['formBUserDetails'] as List)
          .map((item) => FormBUserDetails.fromJson(item))
          .toList(),
    );
  }
}

class FormBUserDetails {
  final int id;
  final String partyName;
  final String mobileNo; // Nullable as it may be empty

  FormBUserDetails({
    required this.id,
    required this.partyName,
    required this.mobileNo,
  });

  factory FormBUserDetails.fromJson(Map<String, dynamic> json) {
    return FormBUserDetails(
      id: json['id'],
      partyName: json['party_name'],
      mobileNo: json['mobile_no'],
    );
  }
}
