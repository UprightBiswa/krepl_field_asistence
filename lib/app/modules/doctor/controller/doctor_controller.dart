import 'dart:async';

import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../farmer/components/filter_bottom_sheet.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/success.dart';
import '../model/doctor_list.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DoctorController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

 
  final PagingController<int, Doctor> pagingController =
      PagingController(firstPageKey: 1);

  static const int pageSize = 10;
  var searchQuery = ''.obs;

  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

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
        FilterOption(label: 'Doctor Name', value: 'doctor_name'),
        FilterOption(label: 'Mobile NO', value: 'mobile_no'),
        FilterOption(label: 'Village Name', value: 'village_name'),
      ],
      initialOrderBy: 'doctor_name',
    );

    pagingController.addPageRequestListener((pageKey) {
      print(
          "Page Request Listener Triggered: ${filterController!.selectedOrderBy.value}");
      fetchDoctors(pageKey, pagingController);
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

  void fetchDoctors(
      int pageKey, PagingController<int, Doctor> pagingController) async {
    print("Fetching Doctors for page: $pageKey");
    try {
      if (pageKey == 1) {
        isListLoading(true);
      }
      isListError(false);
      listErrorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }
      String endPoint = 'viewDoctor';
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
        final doctors = data.map((item) => Doctor.fromJson(item)).toList();
        // Filter out duplicates
        final List<Doctor> uniqueDoctors = doctors.where((farmer) {
          final isDuplicate = _existingItemIds.contains(farmer.id.toString());
          if (!isDuplicate) {
            _existingItemIds.add(farmer.id.toString());
          }
          return !isDuplicate;
        }).toList();

        final isLastPage = pageKey >= response.data['total_pages'];
        if (isLastPage) {
          pagingController.appendLastPage(uniqueDoctors);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(uniqueDoctors, nextPageKey);
        }
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      pagingController.error = e;
      print('Error fetching doctors: $e');
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
    filterController!.selectedOrderBy.value = 'doctor_name';
    filterController!.order.value = 1;
    refreshItems();
  }

  @override
  void onClose() {
    pagingController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  // doctor create
  var isLoadingCreate = false.obs;
  var isErrorCreate = false.obs;
  var errorMessageCreate = ''.obs;

  Future<void> createDoctor(Map<String, dynamic> parameters) async {
    isLoadingCreate(true);
    isErrorCreate(false);
    errorMessageCreate.value = '';

    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      final response =
          await _dioService.post('createDoctor', queryParams: parameters);

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.snackbar('Success', response.data['message'],
            snackPosition: SnackPosition.BOTTOM);
        Get.dialog(
            SuccessDialog(
                message: response.data['message'],
                onClose: () {
                  Get.back();
                  Get.back();
                  Get.back();
                }),
            barrierDismissible: false);
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      isErrorCreate(true);
      errorMessageCreate.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessageCreate.value,
              onClose: () {
                Get.back();
                Get.back();
              }),
          barrierDismissible: false);
      print('Error creating Doctor: $e');
    } finally {
      isLoadingCreate(false);
    }
  }

  //delete doctor
  var isLoadingDelete = false.obs;
  var isErrorDelete = false.obs;
  var errorMessageDelete = ''.obs;

  //end point deleteDoctor and pass doctor id
  Future<void> deleteDoctor(int doctorId) async {
    isLoadingDelete(true);
    isErrorDelete(false);
    errorMessageDelete.value = '';

    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint
      String endPoint = 'deleteDoctor';

      final response = await _dioService.post(endPoint, queryParams: {
        'doctor_id': doctorId,
      });

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
        throw Exception(response.data['message']);
      }
    } catch (e) {
      isErrorDelete(true);
      errorMessageDelete.value = e.toString();
      Get.snackbar('Error', errorMessageDelete.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessageDelete.value,
              onClose: () {
                Get.back();
              }),
          barrierDismissible: false);
      print('Error deleting Doctor: $e');
    } finally {
      isLoadingDelete(false);
    }
  }

  //edit doctor
  var isLoadingEdit = false.obs;
  var isErrorEdit = false.obs;
  var errorMessageEdit = ''.obs;

  //end point editDoctor and Map<String, dynamic> parameters
  Future<void> editDoctor(Map<String, dynamic> parameters) async {
    isLoadingEdit(true);
    isErrorEdit(false);
    errorMessageEdit.value = '';

    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint
      String endPoint = 'editDoctor';

      final response =
          await _dioService.post(endPoint, queryParams: parameters);

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
        throw Exception(response.data['message']);
      }
    } catch (e) {
      isErrorEdit(true);
      errorMessageEdit.value = e.toString();
      Get.snackbar('Error', errorMessageEdit.value);
      Get.dialog(
          ErrorDialog(
              errorMessage: errorMessageEdit.value,
              onClose: () {
                Get.back();
              }),
          barrierDismissible: false);
      print('Error editing Doctor: $e');
    } finally {
      isLoadingEdit(false);
    }
  }


  //fetchall doctor end point  viewDoctor and permeter form_value = all
  var isLoadingAll = false.obs;
  var isErrorAll = false.obs;
  var errorMessageAll = ''.obs;
  var allDoctor = <Doctor>[].obs;

  void fetchAllDoctors() async {
    try {
      isLoadingAll(true);
      isErrorAll(false);
      errorMessageAll.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint and parameters
      String endPoint = 'viewDoctor';
      Map<String, dynamic> parameters = {
        'form_value': 'all',
      };

      final response = await _dioService.post(endPoint, queryParams: parameters);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final doctors = data.map((item) => Doctor.fromJson(item)).toList();
        allDoctor.assignAll(doctors);
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      isErrorAll(true);
      errorMessageAll.value = e.toString();
      print('Error fetching doctors: $e');
    } finally {
      isLoadingAll(false);
    }
  }
  
}
