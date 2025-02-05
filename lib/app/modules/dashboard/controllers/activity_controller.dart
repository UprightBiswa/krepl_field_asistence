import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../../home/model/menu_group.dart';
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
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();
  final RandomColorGenerator colorGenerator = RandomColorGenerator();
  final Map<int, IconData> activityIcons = {
    1: Icons.location_on,
    2: Icons.person_add,
    3: Icons.group,
    4: Icons.meeting_room,
    5: Icons.event,
    6: Icons.science,
    7: Icons.nature,
    8: Icons.campaign,
    9: Icons.air,
    10: Icons.school,
    11: Icons.storefront,
    12: Icons.festival,
    13: Icons.book,
    14: Icons.assignment,
    15: Icons.inventory,
    16: Icons.local_hospital,
  };

  final List<LinearGradient> predefinedGradients = [
    const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
    const LinearGradient(colors: [Colors.red, Colors.pinkAccent]),
    const LinearGradient(colors: [Colors.green, Colors.lightGreenAccent]),
    const LinearGradient(colors: [Colors.orange, Colors.deepOrangeAccent]),
    const LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
  ];

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
      final response = await _dioService.post(
        'faDashboardData',
        queryParams: {'duration_type': 'mtd'},
      );

      final data = response.data['data'] as List;

      mtdData.assignAll(data.map((e) {
        final id = e['id'] as int;
        return ActivityData(
          activityName: e['activity_name'],
          todayActivity: e['today_activity'],
          targetActivityNumbers: e['target_activity'],
          achievedActivityNumbers: e['achieved_activity'],
          icon: activityIcons[id] ?? Icons.dashboard,
          gradientColor: colorGenerator.getGradientForIndex(
            id,
            predefinedGradients,
          ),
          todayActivityColor: Colors.blue,
          targetActivityColor: Colors.green,
          achievedActivityColor: Colors.red,
        );
      }).toList());
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
      final response = await _dioService.post(
        'faDashboardData',
        queryParams: {'duration_type': 'ytd'},
      );

      final data = response.data['data'] as List;
      ytdData.assignAll(data.map((e) {
        final id = e['id'] as int;
        return ActivityData(
          activityName: e['activity_name'],
          todayActivity: e['today_activity'],
          targetActivityNumbers: e['target_activity'],
          achievedActivityNumbers: e['achieved_activity'],
          icon: activityIcons[id] ?? Icons.dashboard,
          gradientColor: colorGenerator.getGradientForIndex(
            id,
            predefinedGradients,
          ),
          todayActivityColor: Colors.blue,
          targetActivityColor: Colors.green,
          achievedActivityColor: Colors.red,
        );
      }).toList());
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
      final response = await _dioService.post(
        'viewFaCustomerSales',
      );
      if (response.data['success'] == true) {
        List<dynamic> dataList = response.data['data'];
        List<SalesData> salesDataList =
            dataList.map((data) => SalesData.fromJson(data)).toList();

        // Filter data for MTD
        mtdSalesData.assignAll(
            salesDataList.where((data) => data.currentMonthTotal > 0).toList());
      } else {
        isErrorMtdSales(true);
      }
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
      final response = await _dioService.post(
        'viewFaCustomerSales',
      );
      if (response.data['success'] == true) {
        List<dynamic> dataList = response.data['data'];
        List<SalesData> salesDataList =
            dataList.map((data) => SalesData.fromJson(data)).toList();

        // Filter data for YTD
        ytdSalesData.assignAll(
            salesDataList.where((data) => data.currentYearTotal > 0).toList());
      } else {
        isErrorYtdSales(true);
      }
    } catch (e) {
      isErrorYtdSales(true);
    } finally {
      isLoadingYtdSales(false);
    }
  }
}
