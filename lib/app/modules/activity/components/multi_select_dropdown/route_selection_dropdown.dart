import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../route_plan/controller/route_controller.dart';
import '../../../route_plan/model/route_list.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart'; // Import ShimmerLoading for a loading effect

class RouteSelectionScreen extends StatefulWidget {
  final void Function(List<RouteMaster>) onSelectionChanged;
  final List<RouteMaster> selectedItems;

  const RouteSelectionScreen({
    super.key,
    required this.onSelectionChanged,
    required this.selectedItems,
  });

  @override
  State<RouteSelectionScreen> createState() => _RouteSelectionScreenState();
}

class _RouteSelectionScreenState extends State<RouteSelectionScreen> {
  final RouteController routeController = Get.put(RouteController());
  late List<RouteMaster> selectedRoutes = [];

  @override
  void initState() {
    super.initState();
    selectedRoutes = widget.selectedItems;
    routeController.fetchRouteMasterData(); // Fetch data from API on init
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (routeController.isLoadingList.value) {
        // Show a loading effect while fetching data
        return const ShimmerLoading();
      } else if (routeController.isErrorList.value) {
        // Show an error message if fetching fails
        return Center(
          child: Text(routeController.errorMessageList.value),
        );
      } else {
        // Show the dropdown with fetched route data
        return MultiSelectDropdown<RouteMaster>(
          labelText: 'Select Routes',
          selectedItems: selectedRoutes,
          items: routeController.routelist,
          itemAsString: (route) => route.routeName, // Show route names in dropdown
          searchableFields: {
            'route_name': (route) => route.routeName,
            'route_code': (route) => route.routeCode,
          },
          validator: (selectedRoutes) {
            if (selectedRoutes.isEmpty) {
              return 'Please select at least one route.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedRoutes = items;
            });
            widget.onSelectionChanged(selectedRoutes);
          },
        );
      }
    });
  }
}
