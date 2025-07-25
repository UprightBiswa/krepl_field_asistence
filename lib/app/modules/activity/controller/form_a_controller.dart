import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/success.dart';
import '../model/form_a_model.dart';

class FormAController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  late final PagingController<int, FormA> pagingController;
  static const int pageSize = 10;
  Timer? _debounce;
  final Set<String> _existingItemIds = <String>{};

  var searchQuery = ''.obs;
  var isListLoading = false.obs;
  var isListError = false.obs;
  var listErrorMessage = ''.obs;

  var fromDate = Rxn<DateTime>(); // Nullable DateTime
  var toDate = Rxn<DateTime>(); // Nullable DateTime
  var partyType = Rxn<String>(); // Nullable partyType (Village, Doctor, Farmer)

  //delete loading
  var isDeleteLoading = false.obs;
  var isDeleteError = false.obs;
  var deleteErrorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController<int, FormA>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) => fetchFormAData(pageKey),
    );
  }

  Future<List<FormA>> fetchFormAData(int pageKey) async {
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
        'from_date': fromDate.value != null
            ? DateFormat('yyyy-MM-dd').format(fromDate.value!)
            : null,
        'to_date': toDate.value != null
            ? DateFormat('yyyy-MM-dd').format(toDate.value!)
            : null,
        'party_type': partyType.value,
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

        return uniqueFormAList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isListError(true);
      listErrorMessage.value = e.toString();
      rethrow;
    } finally {
      isListLoading(false);
    }
  }

  //deltefroma
  Future<void> deleteFormA(int formAId) async {
    try {
      isDeleteLoading(true);
      isDeleteError(false);
      deleteErrorMessage.value = '';

      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      final response = await _dioService.post(
        'deleteFormA',
        queryParams: {'form_a_id': formAId},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: response.data['message'] ?? 'Deleted successfully',
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        refreshItems();
      } else {
        throw Exception(response.data['message'] ?? 'Delete failed');
      }
    } catch (e) {
      isDeleteError(true);
      deleteErrorMessage.value = e.toString();
       Get.snackbar('Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isDeleteLoading(false);
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

  void setFromDate(DateTime date) {
    fromDate.value = date;
    if (toDate.value != null && fromDate.value!.isAfter(toDate.value!)) {
      toDate.value = fromDate.value; // Adjust toDate if invalid
    }
  }

  void setToDate(DateTime date) {
    if (fromDate.value != null && date.isBefore(fromDate.value!)) {
      return; // Prevent invalid date selection
    }
    toDate.value = date;
  }

  void setPartyType(String? type) {
    partyType.value = type;
  }

  void applyDateFilter() {
    if ((fromDate.value != null || toDate.value != null) ||
        partyType.value != null) {
      print("From Date: ${fromDate.value}");
      print("To Date: ${toDate.value}");
      _existingItemIds.clear();
      pagingController.refresh();
    }
  }

  void clearFilters() {
    print("From Date: ${fromDate.value}");
    print("To Date: ${toDate.value}");
    fromDate.value = null;
    toDate.value = null;
    partyType.value = null;
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

      // Compress image before uploading
      File? finalImageFile = imageFile;
      if (imageFile != null && imageFile.existsSync()) {
        finalImageFile = await compressImage(imageFile);
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

      // if (imageFile != null && imageFile.existsSync()) {
      //   formData.files.add(
      //     MapEntry(
      //       'photo',
      //       dio.MultipartFile.fromFileSync(
      //         imageFile.path,
      //         filename: imageFile.path.split('/').last,
      //       ),
      //     ),
      //   );
      // }
      if (finalImageFile != null && finalImageFile.existsSync()) {
        formData.files.add(
          MapEntry(
            'photo',
            dio.MultipartFile.fromFileSync(
              finalImageFile.path,
              filename: finalImageFile.path.split('/').last,
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

  Future<File?> compressImage(File file) async {
    try {
      int fileSize = file.lengthSync();
      int targetSize = 2 * 1024 * 1024; // 2MB in bytes
      int minSize = 1 * 1024 * 1024; // 1MB in bytes

      if (fileSize <= targetSize) {
        print('Image is already under 2MB, compressing slightly.');
      } else {
        print('Image is larger than 2MB, starting compression...');
      }

      int quality = 90; // Start with high quality
      File compressedFile = file;

      while (compressedFile.lengthSync() > targetSize && quality > 10) {
        final dir = await getTemporaryDirectory();
        final targetPath =
            path.join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

        final result = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: quality,
        );

        if (result != null) {
          compressedFile = File(result.path);
        } else {
          print('Compression failed at quality: $quality');
          break;
        }

        print(
            'Compressed size: ${compressedFile.lengthSync() / 1024 / 1024} MB');

        // Stop compressing if it's within the acceptable range
        if (compressedFile.lengthSync() <= targetSize &&
            compressedFile.lengthSync() >= minSize) {
          break;
        }

        // Reduce quality step-by-step
        quality -= 10;
      }

      return compressedFile;
    } catch (e) {
      print('Error in image compression: $e');
      return file; // Return original file if compression fails
    }
  }
}
