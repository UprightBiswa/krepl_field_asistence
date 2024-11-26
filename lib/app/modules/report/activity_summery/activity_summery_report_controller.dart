import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import 'activity_summery_model.dart';

class ActivitySummaryController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  final RxList<ActivitySummary> summaries = <ActivitySummary>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  @override
  void onInit() {
    super.onInit();

    fetchActivitySummary();
  }

  Future<void> fetchActivitySummary({int page = 1}) async {
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
        'activitySummeryReport',
        queryParams: {
          'from_date': formattedFromDate,
          'to_date': formattedToDate,
          'page': page,
          'limit': 10,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          currentPage.value = data['page'];
          totalPages.value = data['total_pages'];
          summaries.value = (data['data'] as List)
              .map((json) => ActivitySummary.fromJson(json))
              .toList();
        } else {
          throw Exception('Failed to load activity summary report.');
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
    fetchActivitySummary();
  }

  void goToNextPage() {
    if (currentPage.value < totalPages.value) {
      fetchActivitySummary(page: currentPage.value + 1);
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      fetchActivitySummary(page: currentPage.value - 1);
    }
  }
}
