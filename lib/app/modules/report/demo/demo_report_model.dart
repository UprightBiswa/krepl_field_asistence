class DemoReport {
  final String farmerName;
  final String villageName;
  final String product;
  final String totalAreaCover;
  final String areaOfDemo;
  final String dosages;
  final String cropName;
  final String status;

  DemoReport({
    required this.farmerName,
    required this.villageName,
    required this.product,
    required this.totalAreaCover,
    required this.areaOfDemo,
    required this.dosages,
    required this.cropName,
    required this.status,
  });

  factory DemoReport.fromJson(Map<String, dynamic> json) {
    return DemoReport(
      farmerName: json['farmer_name'] ?? '',
      villageName: json['village_name'] ?? '',
      product: json['product'] ?? '',
      totalAreaCover: json['total_area_cover'] ?? '',
      areaOfDemo: json['area_of_demo'] ?? '',
      dosages: json['dosages'] ?? '',
      cropName: json['cropname'] ?? '',
      status: json['status'].toString(),
    );
  }
}