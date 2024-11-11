class FormB {
  final int id;
  final String promotionActivityType;
  final String partyType;
  final String? remarks;
  final int totalPartyNo;
  final String createdAt;
  final List<FormBDetails> formBDetails;
  final List<FormBUserDetails> formBUserDetails;

  FormB({
    required this.id,
    required this.promotionActivityType,
    required this.partyType,
    this.remarks,
    required this.totalPartyNo,
    required this.createdAt,
    required this.formBDetails,
    required this.formBUserDetails,
  });

  factory FormB.fromJson(Map<String, dynamic> json) {
    return FormB(
      id: json['id'],
      promotionActivityType: json['promotion_activity_type'],
      partyType: json['party_type'],
      remarks: json['remarks'],
      totalPartyNo: json['total_party_no'],
      createdAt: json['createdAt'],
      formBDetails: (json['formBDetails'] as List)
          .map((item) => FormBDetails.fromJson(item))
          .toList(),
      formBUserDetails: (json['formBUserDetails'] as List)
          .map((item) => FormBUserDetails.fromJson(item))
          .toList(),
    );
  }
}

class FormBDetails {
  final int id;
  final String cropName;
  final String cropStageName;
  final String productName;
  final String pestName;
  final String seasonName;

  FormBDetails({
    required this.id,
    required this.cropName,
    required this.cropStageName,
    required this.productName,
    required this.pestName,
    required this.seasonName,
  });

  factory FormBDetails.fromJson(Map<String, dynamic> json) {
    return FormBDetails(
      id: json['id'],
      cropName: json['crop_name'],
      cropStageName: json['crop_stage_name'],
      productName: json['product_name'],
      pestName: json['pest_name'],
      seasonName: json['season_name'],
    );
  }
}

class FormBUserDetails {
  final int id;
  final String partyName;
  final String routeName;
  final String mobileNo;

  FormBUserDetails({
    required this.id,
    required this.partyName,
    required this.routeName,
    required this.mobileNo,
  });

  factory FormBUserDetails.fromJson(Map<String, dynamic> json) {
    return FormBUserDetails(
      id: json['id'],
      partyName: json['party_name'],
      routeName: json['route_name'],
      mobileNo: json['mobile_no'],
    );
  }
}
