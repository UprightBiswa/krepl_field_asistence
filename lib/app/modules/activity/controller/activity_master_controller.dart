import 'package:get/get.dart';

import '../model/activity_master_model.dart';

class ActivityMasterController extends GetxController {
  // Observables
  var isLoading = true.obs;
  var isError = false.obs;
  var activityMasterList = <ActivityMaster>[].obs;

  // Method to fetch data dynamically
  void fetchActivityMasterData() async {
    try {
      isLoading(true); // Start loading
      isError(false); // Reset error state

      // Simulate a network call or database fetch
      await Future.delayed(const Duration(seconds: 2));

      // Example data, replace this with actual fetching logic
      var fetchedData = [
        ActivityMaster(
            code: 1,
            activityName: "Village Coverage",
            masterLink: "Village",
            form: "No"),
        ActivityMaster(
            code: 2,
            activityName: "New Farmer Registration",
            masterLink: "Farmer",
            form: "F"),
        ActivityMaster(
            code: 3,
            activityName: "One to one farmers contact",
            masterLink: "Farmer",
            form: "A"),
        ActivityMaster(
            code: 4,
            activityName: "Group farmer meeting",
            masterLink: "Farmer",
            form: "A"),
        ActivityMaster(
            code: 5,
            activityName: "Organise Farmer meetings",
            masterLink: "Farmer",
            form: "A"),
        ActivityMaster(
            code: 6,
            activityName: "Demonstrations",
            masterLink: "Farmer",
            form: "D"),
        ActivityMaster(
            code: 7,
            activityName: "Field Days",
            masterLink: "Farmer",
            form: "A"),
        ActivityMaster(
            code: 8,
            activityName: "Jeep campaign",
            masterLink: "Village",
            form: "B"),
        ActivityMaster(
            code: 9,
            activityName: "Baloon show",
            masterLink: "Village",
            form: "A"),
        ActivityMaster(
            code: 10,
            activityName: "KVK Visit",
            masterLink: "Doctor",
            form: "A"),
        ActivityMaster(
            code: 11,
            activityName: "Haat operation",
            masterLink: "Village",
            form: "A"),
        ActivityMaster(
            code: 12, activityName: "Melas", masterLink: "Village", form: "A"),
        ActivityMaster(
            code: 13,
            activityName: "Seminars",
            masterLink: "Village",
            form: "A"),
        ActivityMaster(
            code: 14,
            activityName: "Distribution of POP",
            masterLink: "Village",
            form: "E"),
        ActivityMaster(
            code: 15,
            activityName: "Dealer Stock",
            masterLink: "Retailer",
            form: "C"),
        ActivityMaster(
            code: 16,
            activityName: "New Doctor",
            masterLink: "Doctor",
            form: "G"),
      ];

      // Update the observable list with fetched data
      activityMasterList.assignAll(fetchedData);
    } catch (e) {
      isError(true); // If an error occurs, set isError to true
    } finally {
      isLoading(false); // End loading
    }
  }

  // Fetch specific form type data
  List<ActivityMaster> fetchActivitiesByFormType(String formType) {
    var matchedActivities = activityMasterList
        .where((activity) => activity.form == formType)
        .toList();

    if (matchedActivities.isEmpty) {
      isError(true); // Set error if no activities match the form type
    } else {
      isError(false); // Reset error if matches found
    }

    return matchedActivities;
  }
}
