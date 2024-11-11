import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/success.dart';
import '../model/form_a_model.dart';

class FormAController extends GetxController {
  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  final PagingController<int, FormA> pagingController =
      PagingController(firstPageKey: 1);
  static const int pageSize = 10;
  Timer? _debounce;
  final Set<String> _existingItemIds = <String>{};

  var searchQuery = ''.obs;
  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchFormAData(pageKey);
    });
  }

  Future<void> fetchFormAData(int pageKey) async {
    try {
      if (pageKey == 1) {
        isListLoading(true);
      }
      isListError(false);
      listErrorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      Map<String, dynamic> parameters = {
        'page': pageKey,
        'limit': pageSize,
        'order': -1,
        'order_by': '',
        'filter_value': searchQuery.value,
        'form_value': 'all',
      };

      final response = await _dioService.post(
        'viewFormA',
        queryParams: parameters,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        final formAList = data.map((item) => FormA.fromJson(item)).toList();

        final List<FormA> uniqueFormAList = formAList.where((formA) {
          final isDuplicate = _existingItemIds.contains(formA.id.toString());
          if (!isDuplicate) {
            _existingItemIds.add(formA.id.toString());
          }
          return !isDuplicate;
        }).toList();

        final isLastPage = pageKey >= response.data['total_pages'];
        if (isLastPage) {
          pagingController.appendLastPage(uniqueFormAList);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(uniqueFormAList, nextPageKey);
        }
      } else {
        listErrorMessage.value = "Failed to load data";
        pagingController.error = listErrorMessage.value;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      pagingController.error = e;
    } finally {
      isListLoading(false);
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _existingItemIds.clear();
      pagingController.refresh();
    });
  }

  void refreshItems() {
    print("Refreshing items...");
    _existingItemIds.clear();
    pagingController.refresh();
  }

  @override
  void onClose() {
    pagingController.dispose();
    _debounce?.cancel();
    super.onClose();
  }

  //submitactivityA form data recive end pont // reciev peramnetrs, // recive dio media file as peremter photo
  var isloading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  Future<void> submitActivityAFormData(String endPoint,
      Map<String, dynamic> parameters, List<MapEntry<String, String>> fields,
      {File? imageFile}) async {
    isloading(true);
    isError(false);
    errorMessage('');
    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Prepare the multipart form data
      dio.FormData formData = dio.FormData();

      formData.fields.addAll(
        parameters.entries.map(
          (e) => MapEntry(e.key, e.value.toString()),
        ),
      );

      // Add array/list fields using the MapEntry list `fields`
      formData.fields.addAll(fields);

      if (imageFile != null && imageFile.existsSync()) {
        formData.files.add(
          MapEntry(
            'photo',
            dio.MultipartFile.fromFileSync(
              imageFile.path,
              filename: imageFile.path.split('/').last,
            ),
          ),
        );
      }

      final response = await _dioService.postFormData(endPoint, formData);
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
        print(response.data);
      } else {
        print('Error submitting form  data: ${response.data['message']}');
        String error =
            'Failed to submit form  data: HTTP ${response.statusCode}';
        print(error);
        errorMessage(error);
        throw Exception(error);
      }
    } catch (e) {
      print('Error: $e');
      errorMessage(e.toString());
      isError(true);
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
      isloading(false);
    }
  }
}
