import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../../../controllers/master_controller/product_master_controller.dart';
import '../../../../data/constrants/constants.dart';
import '../../../../model/master/product_master.dart';
import '../../../home/components/search_field.dart';
import '../../../widgets/widgets.dart';

class MultiProductMasterSelector<T> extends StatefulWidget {
  final String labelText;
  final List<ProductMaster> selectedItems;
  final void Function(List<ProductMaster>) onChanged;
  final String Function(ProductMaster) itemAsString;

  const MultiProductMasterSelector({
    super.key,
    required this.labelText,
    required this.selectedItems,
    required this.onChanged,
    required this.itemAsString,
  });

  @override
  _MultiProductMasterSelectorState<T> createState() =>
      _MultiProductMasterSelectorState<T>();
}

class _MultiProductMasterSelectorState<T>
    extends State<MultiProductMasterSelector<T>> {
  late List<ProductMaster> selectedItems;
  String? validationError;

  @override
  void initState() {
    super.initState();
    selectedItems = List<ProductMaster>.from(widget.selectedItems);
  }

  bool isValid() {
    if (selectedItems.isEmpty) {
      setState(() {
        validationError = 'Please select at least one product';
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
        return ProductMasterSelectionBottomSheet<ProductMaster>(
          title: widget.labelText,
          initialSelectedItems: selectedItems,
          onChanged: (List<ProductMaster> updatedSelection) {
            setState(() {
              selectedItems = updatedSelection;
            });
            widget.onChanged(selectedItems);
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
                // Expanded(
                //   child: Text(
                //     selectedItems.isNotEmpty
                //         ? selectedItems.map(widget.itemAsString).join(", ")
                //         : widget.labelText,
                //   ),
                // ),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    children: _buildChips(context),
                  ),
                ),

                Icon(
                  Icons.arrow_drop_down,
                ),
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

  List<Widget> _buildChips(BuildContext context) {
    List<Widget> chips = [];
    for (var i = 0; i < selectedItems.length; i++) {
      if (i < 1) {
        chips.add(_buildChip(selectedItems[i]));
      } else {
        chips.add(_buildSeeAllChip(context));
        break;
      }
    }

    if (chips.isEmpty) {
      chips.add(Text(
        widget.labelText,
        // style: TextStyle(color: Colors.grey[600]),
      ));
    }

    return chips;
  }

  Widget _buildChip(item) {
    return Chip(
      padding: const EdgeInsets.all(0),
      label: Text(widget.itemAsString(item)),
      onDeleted: () {
        setState(() {
          selectedItems.remove(item);
          widget.onChanged(selectedItems);
        });
      },
    );
  }

  Widget _buildSeeAllChip(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.all(0),
      label: const Text("See All"),
      onPressed: () => _showModalBottomSheet(context),
    );
  }
}

class ProductMasterSelectionBottomSheet<T> extends StatefulWidget {
  final String title;
  final void Function(List<ProductMaster>) onChanged;
  final List<ProductMaster> initialSelectedItems;
  final String Function(T) itemAsString;
  const ProductMasterSelectionBottomSheet({
    super.key,
    required this.title,
    required this.onChanged,
    required this.initialSelectedItems,
    required this.itemAsString,
  });

  @override
  _ProductMasterSelectionBottomSheetState<T> createState() =>
      _ProductMasterSelectionBottomSheetState<T>();
}

class _ProductMasterSelectionBottomSheetState<T>
    extends State<ProductMasterSelectionBottomSheet<T>> {
  late ProductMasterController productMasterController;
  TextEditingController searchController = TextEditingController();
  late List<ProductMaster> selectedItems = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    productMasterController = Get.put(ProductMasterController());
    selectedItems = List<ProductMaster>.from(widget.initialSelectedItems);
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
          // Display total products and selected count
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ${productMasterController.productMasters.length}",
                    style: AppTypography.kBold14,
                  ),
                  Text(
                    "Selected: ${selectedItems.length}",
                    style: AppTypography.kBold14.copyWith(color: Colors.green),
                  ),
                ],
              ),
            );
          }),
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
                  // final item = productMasterController.productMasters[index];
                  final item = productMasterController.productMasters[index];
                  final isSelected = selectedItems.any((selected) =>
                      selected.materialNumber == item.materialNumber);
                  return CheckboxListTile(
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
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.removeWhere((selected) =>
                              selected.materialNumber == item.materialNumber);
                        }
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
                    // Clear the selected item
                    selectedItems.clear();
                    widget.onChanged(selectedItems);
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
                  widget.onChanged(selectedItems); // Callback to parent
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
