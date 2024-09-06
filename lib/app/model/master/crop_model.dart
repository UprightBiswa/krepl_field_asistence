// models/crop.dart
class Crop {
  final int id;
  final String? code;
  final String? name;

  Crop({
    required this.id,
    required this.code,
    required this.name,
  });
  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'],
      code: json['code'] ?? "",
      name: json['name']?? "",
    );
  }
}
