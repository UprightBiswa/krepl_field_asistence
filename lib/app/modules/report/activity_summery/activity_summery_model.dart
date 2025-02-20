class ActivitySummary {
  final int id;
  final String promotionalActivity;
  final String activityNumbers;
  final String totalVillage;
  final String totalFarmers;
  final String totalAreaCover;

  ActivitySummary({
    required this.id,
    required this.promotionalActivity,
    required this.activityNumbers,
    required this.totalVillage,
    required this.totalFarmers,
    required this.totalAreaCover,
  });

  factory ActivitySummary.fromJson(Map<String, dynamic> json) {
    return ActivitySummary(
      id: json['id'],
      promotionalActivity: json['promotional_activity'],
      activityNumbers: json['activityNumbers'].toString(),
      totalVillage: json['totalVillage'].toString(),
      totalFarmers: json['totalFarmers'].toString(),
      totalAreaCover: json['totalAreaCover'].toString(),
    );
  }
}
