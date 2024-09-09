class DemoStatus {
  final int id;
  final String code;
  final String name;

  DemoStatus({
    required this.id,
    required this.code,
    required this.name,
  });

  factory DemoStatus.fromJson(Map<String, dynamic> json) {
    return DemoStatus(
      id: json['id'],
      code: json['code'] ?? "",
      name: json['demo_status'] ?? "",
    );
  }
}
