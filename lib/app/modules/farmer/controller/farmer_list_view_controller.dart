import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../components/filter_bottom_sheet.dart';
import '../model/farmer_list.dart';

class FarmerListController extends GetxController {
  late final PagingController<int, Farmer> pagingController;

  static const int pageSize = 10;
  var searchQuery = ''.obs;
  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;
  var allFarmers = <Farmer>[].obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();
  Timer? _debounce;
  final Set<String> _existingItemIds = <String>{};

  FilterController<String>? filterController;

  @override
  void onInit() {
    super.onInit();

    filterController = FilterController<String>(
      filterOptions: [
        FilterOption(label: 'Farmer Name', value: 'farmer_name'),
        FilterOption(label: 'Village Name', value: 'village_name'),
        FilterOption(label: 'Mobile NO', value: 'mobile_no'),
      ],
      initialOrderBy: 'farmer_name',
    );

    pagingController = PagingController<int, Farmer>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) => fetchFarmers(pageKey),
    );
  }

  Future<List<Farmer>> fetchFarmers(int pageKey) async {
    print("Fetching Farmers for page: $pageKey");
    try {
      if (pageKey == 1) {
        isListLoading(true);
        allFarmers.clear();
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

        return uniqueFarmers;
      } else {
        throw Exception('Failed to load farmers');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      print('Error fetching farmers: $e');
      rethrow;
    } finally {
      isListLoading(false);
    }
  }

  void setSearchQuery(String query) {
    print('Search Query: $query');
    print(isError);
    print(isListLoading);
    print(isListError);

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

  //fetch all farmer //end point viewFarmer// peremter form_value =all
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  var allFarmer = <Farmer>[].obs;

  void fetchAllFarmers() async {
    try {
      isLoading(true);
      isError(false);
      errorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint and parameters
      String endPoint = 'viewFarmer';
      Map<String, dynamic> parameters = {
        'form_value': 'all',
      };

      final response =
          await _dioService.post(endPoint, queryParams: parameters);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final farmers = data.map((item) => Farmer.fromJson(item)).toList();
        allFarmer.assignAll(farmers);
        print('Farmer List: ${allFarmer.length}');
      } else {
        throw Exception('Failed to load farmers');
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString();
      print('Error fetching farmers: $e');
    } finally {
      isLoading(false);
    }
  }
}
