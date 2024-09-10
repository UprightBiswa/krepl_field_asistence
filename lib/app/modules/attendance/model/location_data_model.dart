// class LocationDataModel {
//   final int id;
//   final double latitude;
//   final double longitude;
//   final DateTime timestamp;

//   LocationDataModel({
//     required this.id,
//     required this.latitude,
//     required this.longitude,
//     required this.timestamp,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'latitude': latitude,
//       'longitude': longitude,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }

//   static LocationDataModel fromJson(Map<String, dynamic> json) {
//     return LocationDataModel(
//       id: json['id'] as int,
//       latitude: json['latitude'] as double,
//       longitude: json['longitude'] as double,
//       timestamp: DateTime.parse(json['timestamp'] as String),
//     );
//   }
// }

class LocationDataModel {
  final int id;
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  LocationDataModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory LocationDataModel.fromMap(Map<String, dynamic> map) {
    return LocationDataModel(
      id: map['id'] as int,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
