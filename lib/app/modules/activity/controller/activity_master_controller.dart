import 'package:get/get.dart';

import '../../../data/helpers/internet/connectivity_services.dart';
import '../../../data/helpers/utils/dioservice/dio_service.dart';
import '../model/activity_master_model.dart';

class ActivityMasterController extends GetxController {
  // Observables
  var isLoading = true.obs;
  var isError = false.obs;
  var activityMasterList = <ActivityMaster>[].obs;

  // Services
  final DioService _dioService = DioService();
  final ConnectivityService _connectivityService = ConnectivityService();

  // Method to fetch data dynamically
  void fetchActivityMasterData(String formNo) async {
    print('Fetching data for form: $formNo');
    try {
      isLoading(true); // Start loading
      isError(false); // Reset error state
      // Check connectivity
      if (!await _connectivityService.checkInternet()) {
        throw Exception('No internet connection');
      }

      // Example endpoint and parameters
      String endPoint = 'getActivity';
      Map<String, dynamic> parameters = {
        'form_no': formNo,
      };
      // API call
      final response =
          await _dioService.post(endPoint, queryParams: parameters);

      if (response.statusCode == 200 && response.data['success']) {
        // Parse the response data
        var data = response.data['data'] as List;
        var fetchedData =
            data.map((json) => ActivityMaster.fromJson(json)).toList();
        print(response.data);
        // Update the observable list with fetched data
        activityMasterList.assignAll(fetchedData);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isError(true); // If an error occurs, set isError to true
    } finally {
      isLoading(false); // End loading
    }
  }

  // // Simulate a network call or database fetch
  // await Future.delayed(const Duration(seconds: 2));

  //     // Example data, replace this with actual fetching logic
  //     var fetchedData = [
  //       ActivityMaster(
  //           code: 1,
  //           activityName: "Village Coverage",
  //           masterLink: "Village",
  //           form: "No"),
  //       ActivityMaster(
  //           code: 2,
  //           activityName: "New Farmer Registration",
  //           masterLink: "Farmer",
  //           form: "F"),
  //       ActivityMaster(
  //           code: 3,
  //           activityName: "One to one farmers contact",
  //           masterLink: "Farmer",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 4,
  //           activityName: "Group farmer meeting",
  //           masterLink: "Farmer",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 5,
  //           activityName: "Organise Farmer meetings",
  //           masterLink: "Farmer",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 6,
  //           activityName: "Demonstrations",
  //           masterLink: "Farmer",
  //           form: "D"),
  //       ActivityMaster(
  //           code: 7,
  //           activityName: "Field Days",
  //           masterLink: "Farmer",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 8,
  //           activityName: "Jeep campaign",
  //           masterLink: "Village",
  //           form: "B"),
  //       ActivityMaster(
  //           code: 9,
  //           activityName: "Baloon show",
  //           masterLink: "Village",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 10,
  //           activityName: "KVK Visit",
  //           masterLink: "Doctor",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 11,
  //           activityName: "Haat operation",
  //           masterLink: "Village",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 12, activityName: "Melas", masterLink: "Village", form: "A"),
  //       ActivityMaster(
  //           code: 13,
  //           activityName: "Seminars",
  //           masterLink: "Village",
  //           form: "A"),
  //       ActivityMaster(
  //           code: 14,
  //           activityName: "Distribution of POP",
  //           masterLink: "Village",
  //           form: "E"),
  //       ActivityMaster(
  //           code: 15,
  //           activityName: "Dealer Stock",
  //           masterLink: "Retailer",
  //           form: "C"),
  //       ActivityMaster(
  //           code: 16,
  //           activityName: "New Doctor",
  //           masterLink: "Doctor",
  //           form: "G"),
  //     ];

  //     // Update the observable list with fetched data
  //     activityMasterList.assignAll(fetchedData);
  //   } catch (e) {
  //     isError(true); // If an error occurs, set isError to true
  //   } finally {
  //     isLoading(false); // End loading
  //   }
  // }

  // // Fetch specific form type data
  // List<ActivityMaster> fetchActivitiesByFormType(String formType) {
  //   var matchedActivities = activityMasterList
  //       .where((activity) => activity.form == formType)
  //       .toList();

  //   if (matchedActivities.isEmpty) {
  //     isError(true); // Set error if no activities match the form type
  //   } else {
  //     isError(false); // Reset error if matches found
  //   }

  //   return matchedActivities;
  // }
}
