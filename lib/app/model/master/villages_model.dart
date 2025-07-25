class Village {
  final int id;
  final String villageCode;
  final String villageName;
  final String officeName;
  final String tehsil;
  final String city;
  final String pin;
  final String district;
  final String state;
  final String country;
  final String companyCode;
  final String sbCode;
  final String zoneCode;
  final String regionCode;
  final String territoryCode;

  Village({
    required this.id,
    required this.villageCode,
    required this.villageName,
    required this.officeName,
    required this.tehsil,
    required this.city,
    required this.pin,
    required this.district,
    required this.state,
    required this.country,
    required this.companyCode,
    required this.sbCode,
    required this.zoneCode,
    required this.regionCode,
    required this.territoryCode,
  });

  // Factory method to create a Village instance from a JSON map
  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'],
      villageCode: json['village_code'] ?? '',
      villageName: json['village_name'] ?? '',
      officeName: json['officename'] ?? '',
      tehsil: json['tehsil'] ?? '',
      city: json['city'] ?? '',
      pin: json['pin'] ?? '',
      district: json['district'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      companyCode: json['company_code'] ?? '',
      sbCode: json['sb_code'] ?? '',
      zoneCode: json['zone_code'] ?? '',
      regionCode: json['region_code'] ?? '',
      territoryCode: json['territory_code'] ?? '',
    );
  }

  // frommap
  factory Village.fromMap(Map<String, dynamic> map) {
    return Village(
      id: map['id'],
      villageCode: map['village_code'] ?? '',
      villageName: map['village_name'] ?? '',
      officeName: map['officename'] ?? '',
      tehsil: map['tehsil'] ?? '',
      city: map['city'] ?? '',
      pin: map['pin'] ?? '',
      district: map['district'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      companyCode: map['company_code'] ?? '',
      sbCode: map['sb_code'] ?? '',
      zoneCode: map['zone_code'] ?? '',
      regionCode: map['region_code'] ?? '',
      territoryCode: map['territory_code'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Village && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
