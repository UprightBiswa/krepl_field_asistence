// models/crop_stage.dart
class CropStage {
  final int id;
  final String code;
  final String name;

  CropStage({
    required this.id,
    required this.code,
    required this.name,
  });

  factory CropStage.fromJson(Map<String, dynamic> json) {
    return CropStage(
      id: json['id'],
      code: json['code'] ?? "",
      name: json['name'] ?? "",
    );
  }
}
