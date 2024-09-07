import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/success.dart';
import '../model/form_a_model.dart';

class FormAController extends GetxController {
  RxList<FormAModel> formAList = <FormAModel>[].obs;
  RxList<FormAModel> filteredFormAList = <FormAModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      formAList.addAll([
        FormAModel(
          formName: 'Form A1',
          promotionalActivitiesType: 'Demonstration',
          partyType: 'Farmer',
          mobileNumber: '1234567890',
          farmerVillageDoctorName: 'John Doe',
          season: 'Kharif',
          crop: 'Wheat',
          cropStage: 'Vegetative',
          product: 'Pesticide',
          pest: 'Aphids',
          totalNumberFarmerVillageDoctor: 10,
          expense: 500.0,
          photoRequired: true,
          jioLocationTickRequired: false,
          updateMobileNumber: 'Yes',
          remark: 'N/A',
        ),
        FormAModel(
          formName: 'Form A2',
          promotionalActivitiesType: 'Field Day',
          partyType: 'Village',
          mobileNumber: '0987654321',
          farmerVillageDoctorName: 'Jane Doe',
          season: 'Rabi',
          crop: 'Rice',
          cropStage: 'Flowering',
          product: 'Fertilizer',
          pest: 'Bollworm',
          totalNumberFarmerVillageDoctor: 20,
          expense: 1000.0,
          photoRequired: true,
          jioLocationTickRequired: true,
          updateMobileNumber: 'No',
          remark: 'N/A',
        ),
        FormAModel(
          formName: 'Form A3',
          promotionalActivitiesType: 'Training',
          partyType: 'Doctor',
          mobileNumber: '1122334455',
          farmerVillageDoctorName: 'Dr. Smith',
          season: 'Kharif',
          crop: 'Corn',
          cropStage: 'Harvesting',
          product: 'Herbicide',
          pest: 'Armyworm',
          totalNumberFarmerVillageDoctor: 15,
          expense: 750.0,
          photoRequired: false,
          jioLocationTickRequired: true,
          updateMobileNumber: 'Yes',
          remark: 'N/A',
        ),
      ]);
      filteredFormAList.assignAll(formAList);
      isLoading.value = false;
    });
  }

  void filterFormAList(String query) {
    if (query.isEmpty) {
      filteredFormAList.assignAll(formAList);
    } else {
      filteredFormAList.assignAll(
        formAList.where(
          (form) => form.farmerVillageDoctorName
              .toLowerCase()
              .contains(query.toLowerCase()),
        ),
      );
    }
  }

  //submitactivityA form data recive end pont // reciev peramnetrs, // recive dio media file as peremter photo
  var isloading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<void> submitActivityAFormData(
    String endPoint,
    Map<String, dynamic> parameters,
    List<MapEntry<String, String>> fields,
    File? imageFile,
  ) async {
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
                }),
            barrierDismissible: false);
      } else {
        print('Error submitting form A data: ${response.data['message']}');
        String error =
            'Failed to submit form A data: HTTP ${response.statusCode}';
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
