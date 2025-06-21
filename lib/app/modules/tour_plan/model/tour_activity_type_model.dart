class TourActivity {
  final int id;
  final String promotionalActivity;
  final String masterLink;

  TourActivity({
    required this.id,
    required this.promotionalActivity,
    required this.masterLink,
  });

  // Factory method for JSON deserialization
  factory TourActivity.fromJson(Map<String, dynamic> json) {
    return TourActivity(
      id: json['id'] ?? 0,
      promotionalActivity: json['promotional_activity'] ?? '',
      masterLink: json['master_link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'promotional_activity': promotionalActivity,
      'master_link': masterLink,
    };
  }
}
