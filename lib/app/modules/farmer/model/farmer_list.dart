class Farmer {
  final int id;
  final String? promotionActivity;
  final String? farmerName;
  final String? fatherName;
  final String? mobileNo;
  final String? acre;
  final String? pin;
  final String? villageName;
  final String? officeName;
  final String? tehshil;
  final String? district;
  final String? state;
  final String? cow;
  final String? buffalo;
  final String? workplaceCode;
  final String? workplaceName;
  final String? createdAt;

  Farmer({
    required this.id,
    this.promotionActivity,
    this.farmerName,
    this.fatherName,
    this.mobileNo,
    this.acre,
    this.pin,
    this.villageName,
    this.officeName,
    this.tehshil,
    this.district,
    this.state,
    this.cow,
    this.buffalo,
    this.workplaceCode,
    this.workplaceName,
    this.createdAt,
  });

  // Convert JSON to Farmer object
  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'] ?? 0,
      promotionActivity: json['promotion_activity'] as String?,
      farmerName: json['farmer_name'] as String?,
      fatherName: json['father_name'] as String?,
      mobileNo: json['mobile_no'] as String?,
      acre: json['acre'] as String?,
      pin: json['pin'] as String?,
      villageName: json['village_name'] as String?,
      officeName: json['officename'] as String?,
      tehshil: json['tehshil'] as String?,
      district: json['district'] as String?,
      state: json['state'] as String?,
      cow: json['cow'] as String?,
      buffalo: json['buffalo'] as String?,
      workplaceCode: json['workplace_code'] as String?,
      workplaceName: json['workplace_name'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }
}
