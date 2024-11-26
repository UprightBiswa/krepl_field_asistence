import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/route_list.dart';

class RouteReportController extends GetxController {
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  final RxList<RouteModel> routes = <RouteModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final Rx<DateTime> fromDate = DateTime.now().obs;
  final Rx<DateTime> toDate = DateTime.now().obs;
  @override
  void onInit() {
    super.onInit();
    fetchRoutes();
  }

  // Fetch Routes API
  Future<void> fetchRoutes({int page = 1}) async {
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
      print(formattedFromDate);
      print(formattedToDate);
      print(page);
      final response = await _dioService.post(
        'faRouteReport',
        queryParams: {
          'from_date': formattedFromDate,
          'to_date': formattedToDate,
          'page': page,
          'limit': 10,
        },
      );
      print(response.data);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success']) {
          currentPage.value = data['page'];
          totalPages.value = data['total_pages'];
          routes.value = (data['data'] as List)
              .map((json) => RouteModel.fromJson(json))
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
    fetchRoutes();
  }

  void goToNextPage() {
    if (currentPage.value < totalPages.value) {
      fetchRoutes(page: currentPage.value + 1);
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      fetchRoutes(page: currentPage.value - 1);
    }
  }
}
