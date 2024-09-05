class ProductMaster {
  final String materialNumber;
  final String technicalName;
  final String materialDescription;
  final String brandName;

  ProductMaster({
    required this.materialNumber,
    required this.technicalName,
    required this.materialDescription,
    required this.brandName,
  });

  // Factory method to create a ProductMaster from JSON
  factory ProductMaster.fromJson(Map<String, dynamic> json) {
    return ProductMaster(
      materialNumber: json['material_number'],
      technicalName: json['technical_name'],
      materialDescription: json['material_description'],
      brandName: json['brand_name'],
    );
  }
}
