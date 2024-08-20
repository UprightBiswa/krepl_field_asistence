import 'package:get/get.dart';

import '../model/menu_group.dart';

class SearchPageController extends GetxController {
  var searchQuery = ''.obs;
  var selectedCategory = ''.obs;
  var sortOption = 'Name'.obs;
  var isLoading = false.obs; // Indicates if data is being loaded
  var errorMessage = ''.obs; // Holds error messages
  var selectedIndex = (-1).obs;

  final List<MenuItem> allItems = [
    ...shortcutMenuItems,
    ...formMenuItems,
    ...reportMenuItems
  ];
  var filteredItems =
      <MenuItem>[].obs; // Filtered items based on search and filters

  @override
  void onInit() {
    super.onInit();
    // Initialize filtered items with all items
    filteredItems.addAll(allItems);
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterItems();
  }

  void filterItems() {
    isLoading.value = true; // Set loading state to true
    // Filter items based on search query
    filteredItems.value = allItems.where((item) {
      final matchSearch =
          item.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchSearch;
    }).toList();

    if (filteredItems.isEmpty) {
      errorMessage.value = 'No items match your search.';
    } else {
      errorMessage.value = '';
    }
    // If the selected item is no longer visible after filtering, reset the selection
    if (selectedIndex.value >= 0 &&
        selectedIndex.value < filteredItems.length) {
      var selectedItem = filteredItems[selectedIndex.value];
      if (!filteredItems.contains(selectedItem)) {
        selectedIndex.value = -1;
      }
    }

    sortItems();
    isLoading.value = false; // Set loading state to false
  }

  void sortItems() {
    if (sortOption.value == 'Name') {
      filteredItems.sort((a, b) => a.title.compareTo(b.title));
    }
    // Add more sorting logic if needed
  }

  void selectItem(int index) {
    // Update the selected index
    selectedIndex.value = index;
  }
}
