import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route_plan/controller/route_controller.dart';
import '../../route_plan/model/route_list.dart';
import '../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import 'activity_master_dropdown.dart';

class RouteSelectionScreen extends StatefulWidget {
  final void Function(List<RouteMap>)
      onSelectionChanged; // Callback for selected items

  const RouteSelectionScreen({super.key, required this.onSelectionChanged});

  @override
  State<RouteSelectionScreen> createState() => _RouteSelectionScreenState();
}

class _RouteSelectionScreenState extends State<RouteSelectionScreen> {
  final RouteController routeController = Get.put(RouteController());
  List<RouteMap> selectedRoutes = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (routeController.isLoading.value) {
        return const ShimmerLoading();
      } else if (routeController.errorMessage.isNotEmpty) {
        return const Center(
          child: Text('Error loading Routes.'),
        );
      } else {
        return MultiSelectDropdown<RouteMap>(
          labelText: 'Select Routes',
          selectedItems: selectedRoutes,
          items: routeController.allRouteMaps,
          itemAsString: (route) => route.routeName,
          searchableFields: {
            'routeName': (route) => route.routeName,
            'routeNo': (route) =>route.routeNo.toString(),
          },
          validator: (selectedRoutes) {
            if (selectedRoutes.isEmpty) {
              return 'Please select at least one crop.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedRoutes = items;
            });
            widget.onSelectionChanged(
                selectedRoutes); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
