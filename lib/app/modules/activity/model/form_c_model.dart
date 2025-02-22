// // form_c_model.dart

// class FormC {
//   final int id;
//   final String promotionActivityType;
//   final String partyType;
//   final String remarks;
//   final String createdAt;
//   final List<FormCDetail> formCDetails;
//   //lsit of retailers
//   final List<Retailer> retailers;

//   FormC({
//     required this.id,
//     required this.promotionActivityType,
//     required this.partyType,
//     required this.remarks,
//     required this.createdAt,
//     required this.formCDetails,
//     required this.retailers,
//   });

//   factory FormC.fromJson(Map<String, dynamic> json) {
//     return FormC(
//       id: json['id'],
//       promotionActivityType: json['promotion_activity_type'] ?? '',
//       partyType: json['party_type'] ?? '',
//       remarks: json['remarks'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       formCDetails: (json['formCDetails'] as List)
//           .map((item) => FormCDetail.fromJson(item))
//           .toList(),
//       retailers: (json['retailers'] as List)
//           .map((item) => Retailer.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class FormCDetail {
//   final int id;
//   final String productName;
//   final String quantity;
//   final String expense;

//   FormCDetail({
//     required this.id,
//     required this.productName,
//     required this.quantity,
//     required this.expense,
//   });

//   factory FormCDetail.fromJson(Map<String, dynamic> json) {
//     return FormCDetail(
//       id: json['id'],
//       productName: json['product_name'] ?? '',
//       quantity: json['quantity'] ?? '',
//       expense: json['expense'] ?? '',
//     );
//   }
// }

// class Retailer {
//   final String name;
//   final String mobile;
//   Retailer({
//     required this.name,
//     required this.mobile,
//   });

//   factory Retailer.fromJson(Map<String, dynamic> json) {
//     return Retailer(
//       name: json['retailer_name'],
//       mobile: json['phone_no'],
//     );
//   }
// }


class FormC {
  final int id;
  final String promotionActivityType;
  final String partyType;
  final String remarks;
  final String activityPerformedLocation;
  final String activityPerformedDate;
  final String quantity;
  final String expense;
  final String imageUrl;
  final String createdAt;
  final List<String> productDetails;
  final List<Retailer> retailers;

  FormC({
    required this.id,
    required this.promotionActivityType,
    required this.partyType,
    required this.remarks,
    required this.activityPerformedLocation,
    required this.activityPerformedDate,
    required this.quantity,
    required this.expense,
    required this.imageUrl,
    required this.createdAt,
    required this.productDetails,
    required this.retailers,
  });

  factory FormC.fromJson(Map<String, dynamic> json) {
    return FormC(
      id: json['id'] ?? 0,
      promotionActivityType: json['promotion_activity_type'] ?? '',
      partyType: json['party_type'] ?? '',
      remarks: json['remarks'] ?? '',
      activityPerformedLocation: json['activity_performed_location'] ?? '',
      activityPerformedDate: json['activity_performed_date'] ?? '',
      quantity: json['quantity'] ?? '',
      expense: json['expense'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      productDetails: List<String>.from(json['product_details'] ?? []),
      retailers: (json['retailers'] as List<dynamic>?)
              ?.map((item) => Retailer.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Retailer {
  final String retailerName;
  final String phoneNo;

  Retailer({
    required this.retailerName,
    required this.phoneNo,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) {
    return Retailer(
      retailerName: json['retailer_name'] ?? '',
      phoneNo: json['phone_no'] ?? '',
    );
  }
}
