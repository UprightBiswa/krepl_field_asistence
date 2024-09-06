// models/pest.dart
class Pest {
  final int id;
  final String code;
  final String pest;

  Pest({
    required this.id,
    required this.code,
    required this.pest,
  });
  
  factory Pest.fromJson(Map<String, dynamic> json) {
    return Pest(
      id: json['id'],
      code: json['code'] ?? "",
      pest: json['pest'] ?? "",
    );
  }
}
