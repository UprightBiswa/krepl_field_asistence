import 'package:get/get.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../model/cutomer _sales_data.dart';
import '../model/data_model.dart';

class ActivityController extends GetxController {
  // General loading and error states
  var isLoadingMtd = false.obs;
  var isErrorMtd = false.obs;
  var isLoadingYtd = false.obs;
  var isErrorYtd = false.obs;
  var isLoadingMtdSales = false.obs;
  var isErrorMtdSales = false.obs;
  var isLoadingYtdSales = false.obs;
  var isErrorYtdSales = false.obs;

  var mtdData = <ActivityData>[].obs;
  var ytdData = <ActivityData>[].obs;

  // New SalesData
  var mtdSalesData = <SalesData>[].obs;
  var ytdSalesData = <SalesData>[].obs;

  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void onInit() {
    super.onInit();
    fetchMtdData();
    fetchYtdData();
    fetchMtdSalesData();
    fetchYtdSalesData();
  }

  Future<void> fetchMtdData() async {
    isLoadingMtd(true);
    isErrorMtd(false);
    bool isConnected = await _connectivityService.checkInternet();
    if (!isConnected) {
      isLoadingMtd(false);
      isErrorMtd(true);
      return;
    }
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Simulating network delay
      mtdData.assignAll(dummyMtdData); // Assigning dummy data
    } catch (e) {
      isErrorMtd(true);
    } finally {
      isLoadingMtd(false);
    }
  }

  Future<void> fetchYtdData() async {
    isLoadingYtd(true);
    isErrorYtd(false);
    bool isConnected = await _connectivityService.checkInternet();
    if (!isConnected) {
      isLoadingYtd(false);
      isErrorYtd(true);
      return;
    }
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Simulating network delay
      ytdData.assignAll(dummyYtdData); // Assigning dummy data
    } catch (e) {
      isErrorYtd(true);
    } finally {
      isLoadingYtd(false);
    }
  }

  // Fetch methods for SalesData
  Future<void> fetchMtdSalesData() async {
    isLoadingMtdSales(true);
    isErrorMtdSales(false);
    bool isConnected = await _connectivityService.checkInternet();
    if (!isConnected) {
      isLoadingMtdSales(false);
      isErrorMtdSales(true);
      return;
    }
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Simulating network delay
      mtdSalesData.assignAll(dummySalesMTDData); // Assigning dummy data
    } catch (e) {
      isErrorMtdSales(true);
    } finally {
      isLoadingMtdSales(false);
    }
  }

  Future<void> fetchYtdSalesData() async {
    isLoadingYtdSales(true);
    isErrorYtdSales(false);
    bool isConnected = await _connectivityService.checkInternet();
    if (!isConnected) {
      isLoadingYtdSales(false);
      isErrorYtdSales(true);
      return;
    }
    try {
      await Future.delayed(
          const Duration(seconds: 2)); // Simulating network delay
      ytdSalesData.assignAll(dummySalesYTDData); // Assigning dummy data
    } catch (e) {
      isErrorYtdSales(true);
    } finally {
      isLoadingYtdSales(false);
    }
  }
}
