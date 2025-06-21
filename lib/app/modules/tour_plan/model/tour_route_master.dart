class TourRouteMaster {
  final int id;
  final String routeCode;
  final String routeName;

  TourRouteMaster({
    required this.id,
    required this.routeCode,
    required this.routeName,
  });

  // Factory method to create an object from a Map
  factory TourRouteMaster.fromMap(Map<String, dynamic> map) {
    return TourRouteMaster(
      id: map['id'] ?? 0,
      routeCode: map['route_code'] ?? '',
      routeName: map['route_name'] ?? '',
    );
  }
  //fromJson
  factory TourRouteMaster.fromJson(Map<String, dynamic> json) {
    return TourRouteMaster(
      id: json['id'],
      routeCode: json['route_code']?? '',
      routeName: json['route_name'] ??'',
    );
  }
}
