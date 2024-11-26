class Customer {
  final int id;
  final String customerNumber;
  final String customerName;
  final String mobileNumber;
  final String villageName;

  Customer({
    required this.id,
    required this.customerNumber,
    required this.customerName,
    required this.mobileNumber,
    required this.villageName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      customerNumber: json['customer_number'],
      customerName: json['customer_name'],
      mobileNumber: json['mobile_number'],
      villageName: json['village_name'],
    );
  }
}
