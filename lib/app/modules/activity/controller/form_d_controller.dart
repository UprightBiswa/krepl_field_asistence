import 'package:get/get.dart';
import '../model/form_a_model.dart';

class FormDController extends GetxController {
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
          (form) => form.farmerVillageDoctorName.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }
}
