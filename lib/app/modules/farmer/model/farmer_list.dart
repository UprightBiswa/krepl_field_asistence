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

// List<Farmer> farmersList = [
//   Farmer(
//     image:
//         'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg',
//     promotionActivity: 'Activity 1',
//     farmersName: 'Farmer 1',
//     fatherName: 'Father 1',
//     mobileNumber: '1234567890',
//     acre: 2.5,
//     pin: '123456',
//     villageLocalityName: 'Village 1',
//     postOfficeName: 'Post Office 1',
//     subDistName: 'Sub-Dist 1',
//     districtName: 'District 1',
//     stateName: 'State 1',
//     cowCount: 2,
//     buffaloCount: 3,
//     workPlaceCode: 'WPC001',
//     workPlaceName: 'Work Place 1',
//   ),
//   Farmer(
//     image:
//         'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg',
//     promotionActivity: 'Activity 2',
//     farmersName: 'Farmer 2',
//     fatherName: 'Father 2',
//     mobileNumber: '0987654321',
//     acre: 3.0,
//     pin: '654321',
//     villageLocalityName: 'Village 2',
//     postOfficeName: 'Post Office 2',
//     subDistName: 'Sub-Dist 2',
//     districtName: 'District 2',
//     stateName: 'State 2',
//     cowCount: 5,
//     buffaloCount: 1,
//     workPlaceCode: 'WPC002',
//     workPlaceName: 'Work Place 2',
//   ),
//   Farmer(
//     image:
//         'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg',
//     promotionActivity: 'Activity 3',
//     farmersName: 'Farmer 3',
//     fatherName: 'Father 3',
//     mobileNumber: '1234567890',
//     acre: 2.5,
//     pin: '123456',
//     villageLocalityName: 'Village 3',
//     postOfficeName: 'Post Office 3',
//     subDistName: 'Sub-Dist 3',
//     districtName: 'District 3',
//     stateName: 'State 3',
//     cowCount: 2,
//     buffaloCount: 3,
//     workPlaceCode: 'WPC003',
//     workPlaceName: 'Work Place 3',
//   ),
//   Farmer(
//     image:
//         'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg',
//     promotionActivity: 'Activity 4',
//     farmersName: 'Farmer 4',
//     fatherName: 'Father 4',
//     mobileNumber: '0987654321',
//     acre: 3.0,
//     pin: '654321',
//     villageLocalityName: 'Village 4',
//     postOfficeName: 'Post Office 4',
//     subDistName: 'Sub-Dist 4',
//     districtName: 'District 4',
//     stateName: 'State 4',
//     cowCount: 5,
//     buffaloCount: 1,
//     workPlaceCode: 'WPC004',
//     workPlaceName: 'Work Place 4',
//   ),
//   Farmer(
//     image:
//         'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg',
//     promotionActivity: 'Activity 5',
//     farmersName: 'Farmer 5',
//     fatherName: 'Father 5',
//     mobileNumber: '1234567890',
//     acre: 2.5,
//     pin: '123456',
//     villageLocalityName: 'Village 5',
//     postOfficeName: 'Post Office 5',
//     subDistName: 'Sub-Dist 5',
//     districtName: 'District 5',
//     stateName: 'State 5',
//     cowCount: 2,
//     buffaloCount: 3,
//     workPlaceCode: 'WPC005',
//     workPlaceName: 'Work Place 5',
//   ),
//   Farmer(
//     image:
//         'https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg',
//     promotionActivity: 'Activity 6',
//     farmersName: 'Farmer 6',
//     fatherName: 'Father 6',
//     mobileNumber: '0987654321',
//     acre: 3.0,
//     pin: '654321',
//     villageLocalityName: 'Village 6',
//     postOfficeName: 'Post Office 6',
//     subDistName: 'Sub-Dist 6',
//     districtName: 'District 6',
//     stateName: 'State 6',
//     cowCount: 5,
//     buffaloCount: 1,
//     workPlaceCode: 'WPC006',
//     workPlaceName: 'Work Place 6',
//   ),
// ];
