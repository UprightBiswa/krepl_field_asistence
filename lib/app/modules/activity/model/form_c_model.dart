// form_c_model.dart
class FormC {
  final int id;
  final String promotionActivityType;
  final String partyType;
  final String remarks;
  final String createdAt;
  final List<FormCDetail> formCDetails;

  FormC({
    required this.id,
    required this.promotionActivityType,
    required this.partyType,
    required this.remarks,
    required this.createdAt,
    required this.formCDetails,
  });

  factory FormC.fromJson(Map<String, dynamic> json) {
    return FormC(
      id: json['id'],
      promotionActivityType: json['promotion_activity_type'],
      partyType: json['party_type'],
      remarks: json['remarks'],
      createdAt: json['createdAt'],
      formCDetails: (json['formCDetails'] as List)
          .map((item) => FormCDetail.fromJson(item))
          .toList(),
    );
  }
}

class FormCDetail {
  final int id;
  final String partyName;
  final String mobileNo;
  final String productName;
  final String quantity;
  final String expense;

  FormCDetail({
    required this.id,
    required this.partyName,
    required this.mobileNo,
    required this.productName,
    required this.quantity,
    required this.expense,
  });

  factory FormCDetail.fromJson(Map<String, dynamic> json) {
    return FormCDetail(
      id: json['id'],
      partyName: json['party_name'],
      mobileNo: json['mobile_no'],
      productName: json['product_name'],
      quantity: json['quantity'],
      expense: json['expense'],
    );
  }
}
