class PinModel {
  final int id;
  final String pin;

  PinModel({required this.id, required this.pin});

  factory PinModel.fromMap(Map<String, dynamic> map) {
    return PinModel(
      id: map['id'] ?? 0,
      pin: map['pin'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pin': pin,
    };
  }
}
