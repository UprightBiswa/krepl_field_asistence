class LocationDataModel {
  final int id;
  final double latitude;
  final double longitude;
  final String date;
  final String time;

  LocationDataModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': latitude.toString(),
      'long': longitude.toString(),
      'date': date,
      'time': time,
    };
  }

  factory LocationDataModel.fromMap(Map<String, dynamic> map) {
    return LocationDataModel(
      id: map['id'] != null ? map['id'] as int : 0,
      latitude: map['lat'] != null
          ? double.tryParse(map['lat'].toString()) ?? 0.0
          : 0.0,
      longitude: map['long'] != null
          ? double.tryParse(map['long'].toString()) ?? 0.0
          : 0.0,
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
