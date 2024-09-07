class Customer {
  final int id;
  final String customerNumber;
  final String customerName;
  final String regionCode;

  Customer({
    required this.id,
    required this.customerNumber,
    required this.customerName,
    required this.regionCode,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? 0,
      customerNumber: json['customer_number'] ?? '',
      customerName: json['customer_name'] ?? '',
      regionCode: json['region_code'] ?? '',
    );
  }
}