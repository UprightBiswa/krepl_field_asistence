

class CustomerDetails {
  final String customerCode;
  final String customerName;

  CustomerDetails({
    required this.customerCode,
    required this.customerName,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      customerCode: json['customer_code'],
      customerName: json['customer_name'],
    );
  }
}

class Retailer {
  final int id;
  final String code;
  final String retailerName;
  final String mobileNumber;
  final String email;
  final String villageName;
  final String pinCode;
  final String postOfficeName;
  final String subDistName;
  final String districtName;
  final String stateName;
  final List<CustomerDetails> customerDetails;
  final String workplaceCode;
  final String workplaceName;
  final String isActive;
  final DateTime createdAt;

  Retailer({
    required this.id,
    required this.code,
    required this.retailerName,
    required this.mobileNumber,
    required this.email,
    required this.villageName,
    required this.pinCode,
    required this.postOfficeName,
    required this.subDistName,
    required this.districtName,
    required this.stateName,
    required this.customerDetails,
    required this.workplaceCode,
    required this.workplaceName,
    required this.isActive,
    required this.createdAt,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) {
    var customerDetailsJson = json['customer_details'] as List;
    List<CustomerDetails> customerDetailsList =
        customerDetailsJson.map((i) => CustomerDetails.fromJson(i)).toList();
  

    return Retailer(
      id: json['id'],
      code: json['code'],
      retailerName: json['retailer_name'],
      mobileNumber: json['mobile_no'],
      email: json['email'],
      villageName: json['village_name'],
      pinCode: json['pin'],
      postOfficeName: json['officename'],
      subDistName: json['tehshil'],
      districtName: json['district'],
      stateName: json['state'],
      customerDetails: customerDetailsList,
      workplaceCode: json['workplace_code'],
      workplaceName: json['workplace_name'],
      isActive: json['is_active'].toString(),
      // dd-MM-yyyy  make formete date
      createdAt: DateTime.parse(json['createdAt']),

      
      // createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
