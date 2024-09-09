
class DemoResult {
  final int id;
  final String code;
  final String name;

  DemoResult({
    required this.id,
    required this.code,
    required this.name,
  });

  factory DemoResult.fromJson(Map<String, dynamic> json) {
    return DemoResult(
      id: json['id'],
      code: json['code'] ?? "",
      name: json['result'] ?? "",
    );
  }
}
