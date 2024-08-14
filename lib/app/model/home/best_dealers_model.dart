import '../../data/constrants/constants.dart';

class BestTeachersModel {
  String name;
  String bio;
  String image;
  int position;
  BestTeachersModel({
    required this.name,
    required this.bio,
    required this.image,
    required this.position,
  });
}

List<BestTeachersModel> bestTeachers = [
  BestTeachersModel(
    name: 'Martín Abasto',
    bio: 'KREPL',
    image: AppAssets.kUser3,
    position: 1,
  ),
  BestTeachersModel(
    name: 'Emmy Elsner',
    bio: 'AGRO',
    image: AppAssets.kUser6,
    position: 2,
  ),
  BestTeachersModel(
    name: 'Meng Ru',
    bio: 'KREPL',
    image: AppAssets.kUser7,
    position: 3,
  ),
];
