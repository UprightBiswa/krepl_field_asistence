class ActivitySummary {
  final int id;
  final String promotionalActivity;
  final int activityNumbers;
  final int totalVillage;
  final int totalFarmers;
  final int totalAreaCover;

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
      activityNumbers: json['activityNumbers'],
      totalVillage: json['totalVillage'],
      totalFarmers: json['totalFarmers'],
      totalAreaCover: json['totalAreaCover'],
    );
  }
}
