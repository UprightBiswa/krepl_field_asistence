import 'dart:async';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/success.dart';
import '../components/filter_bottom_sheet.dart';
import '../model/farmer_list.dart';

class FarmerController extends GetxController {
  //for create farmer
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  // //for list pegination of farmers filter search
  final PagingController<int, Farmer> pagingController =
      PagingController(firstPageKey: 1);
  static const int pageSize = 10;
  var searchQuery = ''.obs;
  var orderBy = 'village_name'.obs;
  var order = 1.obs;
  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  List<Farmer> allFarmers = <Farmer>[];

  var recentFarmers = <Farmer>[].obs;

  // var filteredFarmers = <Farmer>[].obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();
  Timer? _debounce;
  final Set<String> _existingItemIds = <String>{};

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchFarmers(pageKey);
    });
  }

  Future<void> fetchFarmers(int pageKey) async {
    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }
      if (pageKey == 1) {
        isListLoading(true);
      }
      isListError(false);
      listErrorMessage.value = '';

      final response = await _dioService.post(
        'viewFarmer',
        queryParams: {
          'page': pageKey,
          'order': order.value,
          'order_by': orderBy.value,
          'limit': pageSize,
          'filter_value': searchQuery.value,
        },
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
        //allFarmers.addAll(farmers);
        allFarmers = uniqueFarmers;
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
    searchQuery.value = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      refreshItems();
    });
  }

  void setOrderBy(String field) {
    orderBy.value = field;
  }

  void setOrder(int sortOrder) {
    order.value = sortOrder;
  }

  void refreshItems() {
    _existingItemIds.clear();
    pagingController.refresh();
  }

  void clearFilters() {
    searchQuery.value = '';
    orderBy.value = 'village_name';
    order.value = -1;
    refreshItems();
  }

  // Initialize the FilterController with necessary options
  final FilterController<String> filterController = FilterController<String>(
    filterOptions: [
      FilterOption(label: 'Village Name', value: 'village_name'),
      FilterOption(label: 'Mobile NO', value: 'mobile_no'),
      FilterOption(label: 'Farmer Name', value: 'farmer_name'),
    ],
    initialOrderBy: 'village_name',
  );
  @override
  void onClose() {
    pagingController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  Future<void> fetchRecentFarmers() async {
    try {
      isLoading(true);
      isError(false);
      errorMessage.value = '';

      // Replace 'yourApiEndpoint' with the actual endpoint for fetching farmers
      final response = await _dioService.post('viewFarmer', queryParams: {
        'limit': 5,
        'order': -1,
        'order_by': 'village_name',
      });

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final farmers = data.map((item) => Farmer.fromJson(item)).toList();
        recentFarmers.assignAll(farmers);
      } else {
        throw Exception('Failed to load recent farmers');
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString();
       print('Error fetching recent farmers: $e');
    } finally {
      isLoading(false);
    }
  }

  //create from
  Future<void> submitFarmerData(Map<String, dynamic> parameters) async {
    isLoading(true);
    isError(false);
    errorMessage('');

    try {
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint
      String endPoint = 'createFarmer';

      // API call
      final response =
          await _dioService.post(endPoint, queryParams: parameters);

      // Handle response
      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', response.data['message'],
            snackPosition: SnackPosition.BOTTOM);
        Get.dialog(
            SuccessDialog(
                message: response.data['message'],
                onClose: () {
                  Get.back();
                  Get.back();
                }),
            barrierDismissible: false);
      } else {
        // Handle error in response
        throw Exception(response.data['message']);
      }
    } catch (e) {
      // Handle exception
      isError(true);
      errorMessage(e.toString());
      Get.snackbar('Error', errorMessage.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessage.value,
              onClose: () {
                Get.back();
                Get.back();
              }),
          barrierDismissible: false);
    } finally {
      isLoading(false);
    }
  }
}
