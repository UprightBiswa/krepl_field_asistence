class Activity {
  final int id;
  final String createdAt;
  final String promotionalActivity;
  final String partyType;
  final String farmerName;
  final String villageName;
  final String acre;
  final String crop;

  Activity({
    required this.id,
    required this.createdAt,
    required this.promotionalActivity,
    required this.partyType,
    required this.farmerName,
    required this.villageName,
    required this.acre,
    required this.crop,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      createdAt: json['created_at'],
      promotionalActivity: json['promotional_activity'],
      partyType: json['party_type'],
      farmerName: json['farmer_name'],
      villageName: json['village_name'],
      acre: json['acre'],
      crop: json['crop'],
    );
  }
}
