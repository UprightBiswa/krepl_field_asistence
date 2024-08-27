import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/master_controller.dart/product_master_controller.dart';
import '../../../../model/master/product_master.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

class ProductMasterSelectionScreen extends StatefulWidget {
  final void Function(List<ProductMaster>)
      onSelectionChanged; // Callback for selected items

  const ProductMasterSelectionScreen(
      {super.key, required this.onSelectionChanged});

  @override
  State<ProductMasterSelectionScreen> createState() =>
      _ProductMasterSelectionScreenState();
}

class _ProductMasterSelectionScreenState
    extends State<ProductMasterSelectionScreen> {
  final ProductMasterController productMasterController =
      Get.put(ProductMasterController());
  List<ProductMaster> selectedProductMasters = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productMasterController.isLoading.value) {
        return const ShimmerLoading();
      } else if (productMasterController.error.isNotEmpty) {
        return const Center(
          child: Text('Error loading ProductMasters.'),
        );
      } else {
        return MultiSelectDropdown<ProductMaster>(
          labelText: 'Select ProductMasters',
          selectedItems: selectedProductMasters,
          items: productMasterController.productMasters,
          itemAsString: (productMaster) => productMaster.meterialName,
          searchableFields: {
            'meterialName': (productMaster) => productMaster.meterialName,
            'meterialCode': (productMaster) => productMaster.meterialCode,
          },
          validator: (selectedProductMasters) {
            if (selectedProductMasters.isEmpty) {
              return 'Please select at least one ProductMaster.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedProductMasters = items;
            });
            widget.onSelectionChanged(
                selectedProductMasters); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
