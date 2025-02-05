class FormE {
  final int id;
  final String promotionActivityType;
  final String partyType;
  final String latitude;
  final String longitude;
  final String? remarks;
  final int totalPartyNo;
  final String createdAt;
  final List<FormEDetail> formEDetails;
  final List<FormEUserDetail> formEUserDetails;
  final String imageUrl; // Added imageUrl field

  FormE({
    required this.id,
    required this.promotionActivityType,
    required this.partyType,
    required this.latitude,
    required this.longitude,
    this.remarks,
    required this.totalPartyNo,
    required this.createdAt,
    required this.formEDetails,
    required this.formEUserDetails,
    required this.imageUrl, // Added imageUrl parameter
  });

  factory FormE.fromJson(Map<String, dynamic> json) => FormE(
        id: json['id'],
        promotionActivityType: json['promotion_activity_type'],
        partyType: json['party_type'],
        latitude: json['latitude'] ?? '',
        longitude: json['longitude'] ?? '',
        remarks: json['remarks'] ?? '',
        totalPartyNo: json['total_party_no'] ?? '',
        createdAt: json['createdAt'] ?? '',
        formEDetails: (json['formEDetails'] as List)
            .map((e) => FormEDetail.fromJson(e))
            .toList(),
        formEUserDetails: (json['formEUserDetails'] as List)
            .map((e) => FormEUserDetail.fromJson(e))
            .toList(),
        imageUrl: json['image_url'] ?? '', // Handle image_url
      );
}

class FormEDetail {
  final int id;
  final String cropName;
  final String cropStageName;
  final String productName;
  final String pestName;
  final String expense;
  final String publicityMat;
  final String seasonName;

  FormEDetail({
    required this.id,
    required this.cropName,
    required this.cropStageName,
    required this.productName,
    required this.pestName,
    required this.expense,
    required this.publicityMat,
    required this.seasonName,
  });

  factory FormEDetail.fromJson(Map<String, dynamic> json) => FormEDetail(
        id: json['id'],
        cropName: json['crop_name'],
        cropStageName: json['crop_stage_name'],
        productName: json['product_name'],
        pestName: json['pest_name'],
        expense: json['expense'],
        publicityMat: json['publicity_mat'],
        seasonName: json['season_name'],
      );
}

class FormEUserDetail {
  final int id;
  final String partyName;
  final String mobileNo;

  FormEUserDetail({
    required this.id,
    required this.partyName,
    required this.mobileNo,
  });

  factory FormEUserDetail.fromJson(Map<String, dynamic> json) =>
      FormEUserDetail(
        id: json['id'],
        partyName: json['party_name'],
        mobileNo: json['mobile_no'],
      );
}
