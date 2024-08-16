// Village Model
class Village {
  final String villageCode;
  final String villageName;

  Village({
    required this.villageCode,
    required this.villageName,
  });
}
// Dummy Villages
final List<Village> villagesList = [
  Village(villageCode: "V001", villageName: "Village X"),
  Village(villageCode: "V002", villageName: "Village Y"),
  Village(villageCode: "V003", villageName: "Village Z"),
];