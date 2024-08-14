import 'package:get/get.dart';

import '../model/menu_group.dart';

class SearchPageController extends GetxController {
  var searchQuery = ''.obs;
  var selectedCategory = ''.obs;
  var sortOption = 'Name'.obs;
  var isLoading = false.obs; // Indicates if data is being loaded
  var errorMessage = ''.obs; // Holds error messages

  final List<MenuItem> allItems = [...reportMenuItems, ...formMenuItems];
  var filteredItems = <MenuItem>[].obs; // Filtered items based on search and filters

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
      final matchSearch = item.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchSearch;
    }).toList();
    
    if (filteredItems.isEmpty) {
      errorMessage.value = 'No items match your search.';
    } else {
      errorMessage.value = '';
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
}
