import 'package:get/get.dart';
// import 'package:dio/dio.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../model/data_model.dart';

class ActivityController extends GetxController {
  var isLoading = true.obs;
  var isError = false.obs;
  var mtdData = <ActivityData>[].obs;
  var ytdData = <ActivityData>[].obs;

  // final Dio _dio = Dio();
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void onInit() {
    fetchMtdData();
    fetchYtdData();
    super.onInit();
  }

  Future<void> fetchMtdData() async {
    isLoading(true);
    isError(false);
    bool isConnected = await _connectivityService.checkInternet();
    if (!isConnected) {
      isLoading(false);
      isError(true);
      return;
    }
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
      mtdData.assignAll(dummyMtdData ); // Assigning dummy data
      isLoading(false);
    } catch (e) {
      isLoading(false);
      isError(true);
    }
  }

  Future<void> fetchYtdData() async {
    isLoading(true);
    isError(false);
    bool isConnected = await _connectivityService.checkInternet();
    if (!isConnected) {
      isLoading(false);
      isError(true);
      return;
    }
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
      ytdData.assignAll(dummyYtdData); // Assigning dummy data
      isLoading(false);
    } catch (e) {
      isLoading(false);
      isError(true);
    }
  }
}
