import 'package:get/get.dart';


import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/expense_type_model.dart';

class ExpenseTypeController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<ExpenseType> expenseTypes = <ExpenseType>[].obs;

  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  Future<void> fetchExpenseTypes() async {
    isLoading(true);
    isError(false);
    errorMessage('');

    try {
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // API call
      final response = await _dioService.post('getExpenseType');
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        expenseTypes.assignAll(data.map((e) => ExpenseType.fromJson(e)).toList());
      } else {
        throw Exception(response.data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
