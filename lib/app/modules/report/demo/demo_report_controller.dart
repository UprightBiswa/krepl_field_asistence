import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import 'demo_report_model.dart';

class DemoReportController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  final RxList<DemoReport> demoReports = <DemoReport>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDemoReport();
  }

  Future<void> fetchDemoReport({int page = 1}) async {
    isLoading.value = true;
    hasError.value = false;

    try {
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Format dates before sending
      final String formattedFromDate =
          DateFormat('yyyy-MM-dd').format(fromDate.value);
      final String formattedToDate =
          DateFormat('yyyy-MM-dd').format(toDate.value);

      final response = await _dioService.post(
        'faDemoReport',
        queryParams: {
          'from_date': formattedFromDate,
          'to_date': formattedToDate,
          'page': page,
          'limit': 10,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true) {
          currentPage.value = data['current_page'];
          totalPages.value = data['total_pages'];
          demoReports.value = (data['data'] as List)
              .map((json) => DemoReport.fromJson(json))
              .toList();
        } else {
          throw Exception(data['message'] ?? 'Failed to load demo report.');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateDateRange(DateTime start, DateTime end) {
    fromDate.value = start;
    toDate.value = end;
    currentPage.value = 1;
    fetchDemoReport();
  }

  void goToNextPage() {
    if (currentPage.value < totalPages.value) {
      fetchDemoReport(page: currentPage.value + 1);
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      fetchDemoReport(page: currentPage.value - 1);
    }
  }
}