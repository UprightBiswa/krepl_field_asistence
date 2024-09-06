import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../components/filter_bottom_sheet.dart';
import '../model/farmer_list.dart';

class FarmerListController extends GetxController {
  // //for list pegination of farmers filter search
  final PagingController<int, Farmer> pagingController =
      PagingController(firstPageKey: 1);

  static const int pageSize = 10;
  var searchQuery = ''.obs;
  // var orderBy = 'farmer_name'.obs;
  // var order = 1.obs;

  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  var allFarmers = <Farmer>[].obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();
  Timer? _debounce;
  final Set<String> _existingItemIds = <String>{};

  FilterController<String>? filterController;

  @override
  void onInit() {
    super.onInit();
    print("FarmerListController initialized");

    filterController = FilterController<String>(
      filterOptions: [
        FilterOption(label: 'Village Name', value: 'village_name'),
        FilterOption(label: 'Mobile NO', value: 'mobile_no'),
        FilterOption(label: 'Farmer Name', value: 'farmer_name'),
      ],
      initialOrderBy: 'farmer_name',
    );

    pagingController.addPageRequestListener((pageKey) {
      print(
          "Page Request Listener Triggered: ${filterController!.selectedOrderBy.value}");
      fetchFarmers(pageKey, pagingController);
    });

    // Log and refresh items when filter changes
    filterController!.selectedOrderBy.listen((value) {
      print('Order By changed: $value');
      // refreshItems();
    });

    filterController!.order.listen((value) {
      print('Order changed: $value');
      // refreshItems();
    });
  }

  void fetchFarmers(
      int pageKey, PagingController<int, Farmer> pagingController) async {
    print("Fetching Farmers for page: $pageKey");
    try {
      if (pageKey == 1) {
        isListLoading(true);
      }
      isListError(false);
      listErrorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }
      String endPoint = 'viewFarmer';
      Map<String, dynamic> parameters = {
        'page': pageKey,
        'limit': pageSize,
        'order': filterController!.order.value,
        'order_by': filterController!.selectedOrderBy.value,
        'filter_value': searchQuery.value,
      };

      final response = await _dioService.post(
        endPoint,
        queryParams: parameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final farmers = data.map((item) => Farmer.fromJson(item)).toList();
        // Filter out duplicates
        final List<Farmer> uniqueFarmers = farmers.where((farmer) {
          final isDuplicate = _existingItemIds.contains(farmer.id.toString());
          if (!isDuplicate) {
            _existingItemIds.add(farmer.id.toString());
          }
          return !isDuplicate;
        }).toList();

        final isLastPage = pageKey >= response.data['total_pages'];
        if (isLastPage) {
          pagingController.appendLastPage(uniqueFarmers);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(uniqueFarmers, nextPageKey);
        }
        allFarmers.addAll(uniqueFarmers);
      } else {
        throw Exception('Failed to load farmers');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      pagingController.error = e;
      print('Error fetching farmers: $e');
    } finally {
      isListLoading(false);
    }
  }

  void setSearchQuery(String query) {
    print('Search Query: $query');
    searchQuery.value = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      refreshItems();
    });
  }

  void refreshItems() {
    print("Refreshing items...");
    _existingItemIds.clear();
    pagingController.refresh();
  }

  void clearFilters() {
    searchQuery.value = '';
    filterController!.selectedOrderBy.value = 'farmer_name';
    filterController!.order.value = 1;
    refreshItems();
  }

  @override
  void onClose() {
    pagingController.dispose();
    _debounce?.cancel();
    super.onClose();
  }
}