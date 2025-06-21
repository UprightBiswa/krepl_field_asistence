import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../../controllers/master_controller/product_master_controller.dart';
import '../../../../data/constrants/constants.dart';
import '../../../home/components/search_field.dart';
import '../../../widgets/widgets.dart';

class ProductMasterSelector<T> extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final T? selectedItem;
  final Function(dynamic) onChanged; // callback for selected item
  final String Function(dynamic) itemAsString; // function to display item text

  const ProductMasterSelector({
    super.key,
    required this.labelText,
    required this.icon,
    required this.selectedItem,
    required this.onChanged,
    required this.itemAsString,
  });

  @override
  State<ProductMasterSelector> createState() => _ProductMasterSelectorState();
}

class _ProductMasterSelectorState extends State<ProductMasterSelector> {
  dynamic selectedItem; // Changed from List to a single item
  String? validationError;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem; // Set initial selected item
  }

  bool isValid() {
    if (selectedItem == null) {
      setState(() {
        validationError = 'Please select a product';
      });
      return false;
    } else {
      setState(() {
        validationError = null;
      });
      return true;
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return ProductMasterSelectionBottomSheet(
          title: widget.labelText,
          initialSelectedItem: selectedItem ?? widget.selectedItem,
          onChanged: (item) {
            setState(() {
              selectedItem = item;
            });
            widget.onChanged(item);
            Navigator.of(context).pop();
          },
          itemAsString: widget.itemAsString,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showModalBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: validationError != null ? Colors.red : Colors.grey,
              ),
              color: AppColors.kInput,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedItem != null
                        ? widget.itemAsString(selectedItem)
                        : widget.labelText,
                  ),
                ),
                Icon(widget.icon),
              ],
            ),
          ),
        ),
        if (validationError != null) ...[
          const SizedBox(height: 5),
          Text(
            validationError!,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ],
    );
  }
}

class ProductMasterSelectionBottomSheet extends StatefulWidget {
  final String title;
  final Function(dynamic) onChanged;
  final dynamic initialSelectedItem; // To keep track of initial selected item
  final String Function(dynamic) itemAsString;

  const ProductMasterSelectionBottomSheet({
    super.key,
    required this.title,
    required this.onChanged,
    required this.initialSelectedItem,
    required this.itemAsString,
  });

  @override
  State<ProductMasterSelectionBottomSheet> createState() =>
      _ProductMasterSelectionBottomSheetState();
}

class _ProductMasterSelectionBottomSheetState
    extends State<ProductMasterSelectionBottomSheet> {
  late ProductMasterController productMasterController;
  TextEditingController searchController = TextEditingController();
  dynamic selectedItem;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    productMasterController = Get.put(ProductMasterController());
    selectedItem = widget.initialSelectedItem;
  }

  void _filterItems(String search) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      productMasterController.loadProductMasters(search);
    });
  }

  void _clearSearch() {
    searchController.clear();
    productMasterController.loadProductMasters('000');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: AppTypography.kBold14),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    controller: searchController,
                    onChanged: _filterItems,
                    isEnabled: true,
                    hintText: 'Search',
                  ),
                ),

                //add suffix icon x
                IconButton(
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.clear),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (productMasterController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (productMasterController.error.isNotEmpty) {
                return Center(
                    child: Text(
                  'Error: ${productMasterController.error.value}',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ));
              }
              if (productMasterController.productMasters.isEmpty) {
                return const Center(
                    child: Text(
                  'No products found.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: productMasterController.productMasters.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
                itemBuilder: (context, index) {
                  final item = productMasterController.productMasters[index];
                  final isSelected = selectedItem == item;

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.h),
                    tileColor: isSelected
                        ? AppColors.kPrimary.withValues(
                            alpha: 90,
                          )
                        : null,
                    title: Text(item.brandName, style: AppTypography.kBold14),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.materialDescription,
                            style: AppTypography.kBold12),
                        Text(item.materialNumber,
                            style: AppTypography.kMedium12),
                        Text(item.technicalName,
                            style: AppTypography.kMedium12),
                      ],
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_box)
                        : const Icon(Icons.check_box_outline_blank),
                    onTap: () {
                      setState(() {
                        selectedItem = item; // Update selected item
                      });
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onTap: () {
                  setState(() {
                    selectedItem = null; // Clear the selected item
                    widget.onChanged(selectedItem);
                  });
                },
                text: "Clear",
                color: AppColors.kAccent1,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: PrimaryButton(
                color: AppColors.kPrimary,
                onTap: () {
                  widget.onChanged(selectedItem); // Callback to parent
                },
                text: "Done",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
