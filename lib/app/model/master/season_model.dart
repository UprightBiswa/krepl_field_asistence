class Season {
  final int id;
  final String code;
  final String season;

  Season({
    required this.id,
    required this.code,
    required this.season,
  });

  // Factory constructor to create a Season instance from JSON
  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      season: json['season'] ?? '',
    );
  }
}
