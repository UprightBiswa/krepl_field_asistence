// WorkPlace Model
class WorkPlace {
  final String workPlaceCode;
  final String workPlaceName;

  WorkPlace({
    required this.workPlaceCode,
    required this.workPlaceName,
  });
}

// Dummy WorkPlaces
final List<WorkPlace> workPlacesList = [
  WorkPlace(workPlaceCode: "WP001", workPlaceName: "Head Office"),
  WorkPlace(workPlaceCode: "WP002", workPlaceName: "Regional Office"),
  WorkPlace(workPlaceCode: "WP003", workPlaceName: "Field Office"),
];