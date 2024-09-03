import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/model/master/season_model.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/master/crop_model.dart';
import '../../../model/master/crop_stage.dart';
import '../../../model/master/pest_master.dart';

import '../../route_plan/model/route_list.dart';
import '../../widgets/form_field.dart/form_field.dart';
import '../../widgets/widgets.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/multi_select_dropdown/crop_selection_dropdown.dart';
import '../components/multi_select_dropdown/pest_selection_dropdown.dart';
import '../components/multi_select_dropdown/products_selection_drodown.dart';
import '../components/multi_select_dropdown/route_selection_dropdown.dart';
import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
import '../components/multi_select_dropdown/stages_selection_dropdown.dart';
import '../model/activity_master_model.dart';

class CreateFormBpage extends StatefulWidget {
  const CreateFormBpage({super.key});

  @override
  State<CreateFormBpage> createState() => _CreateFormBpageState();
}

class _CreateFormBpageState extends State<CreateFormBpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _remarksController = TextEditingController();

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;
  List<RouteMap> selectedRoutes = [];

  List<Season> selectedSeasions = [];
  List<Crop> selectedCrops = [];
  List<CropStage> selectedCropStages = [];
  List<ProductMaster> selectedProducts = [];
  List<Pest> selectedPests = [];

  String? totalSelectedPertyType;

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Create Jeep Campaign',
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActivitySelectionWidget(
                      formType: "B",
                       onSaved: (selectedActivity) {
                        setState(() {
                          _selectedActivity = selectedActivity;

                          if (_selectedActivity != null) {
                            selectedPartyType = _selectedActivity!.masterLink;
                          }
                        });
                      },
                      validator: (selectedActivity) {
                        if (selectedActivity == null) {
                          return 'Please select an activity';
                        }
                        return null;
                      },
                    ),
                    if (_selectedActivity != null) ...[
                      SizedBox(height: 16.h),
                      Text(
                        'Selected Partytype: ${_selectedActivity!.masterLink}',
                      ),
                    ],
                    SizedBox(height: 16.h),
                    RouteSelectionScreen(
                      onSelectionChanged: (selectedRoutes) {
                        setState(() {
                          selectedRoutes = selectedRoutes;
                        });
                      },
                    ),
                    
                    SizedBox(height: 16.h),
                    
                  ],
                ),
              ),
              const SizedBox(height: 16),
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeasionSelectionScreen(
                      onSelectionChanged: (selectedSeasionsitems) {
                        setState(() {
                          selectedSeasions = selectedSeasionsitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CropSelectionScreen(
                      onSelectionChanged: (selectedCropsitems) {
                        setState(() {
                          selectedCrops = selectedCropsitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CropStageSelectionScreen(
                      onSelectionChanged: (selectedCropStagesitems) {
                        setState(() {
                          selectedCropStages = selectedCropStagesitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ProductMasterSelectionScreen(
                      onSelectionChanged: (selectedProductsitems) {
                        setState(() {
                          selectedProducts = selectedProductsitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    PestSelectionScreen(
                      onSelectionChanged: (selectedPestsitems) {
                        setState(() {
                          selectedPests = selectedPestsitems;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              PrimaryContainer(
                child: CustomTextField(
                  labelText: 'Remarks',
                  hintText: 'Enter remarks',
                  icon: Icons.comment,
                  controller: _remarksController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter remarks';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: isDarkMode(context)
              ? AppColors.kDarkSurfaceColor
              : AppColors.kInput,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle form submission logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                text: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
