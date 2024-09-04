// controllers/doctor_controller.dart
import 'package:get/get.dart';

class Customer {
  final int id;
  final String name;
  final String code;
  Customer({
    required this.id,
    required this.name,
    required this.code,
  });
}

List<Customer> dummyCustomers = [
  Customer(id: 1, name: "John Doe", code: '123'),
  Customer(id: 2, name: "Jane Smith", code: '456'),
  Customer(id: 3, name: "Emily Clark", code: '789')
];

class CustomerController extends GetxController {
  var customer = <Customer>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  @override
  void onInit() {
    loadcustomer();
    super.onInit();
  }

  Future<void> loadcustomer() async {
    isLoading.value = true;
    error.value = '';

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Load data (replace with actual data loading logic)
      customer.assignAll(dummyCustomers);
    } catch (e) {
      error.value = 'Failed to load data';
    } finally {
      isLoading.value = false;
    }
  }
}
