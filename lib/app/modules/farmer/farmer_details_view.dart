import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../widgets/components/Info_row_widget.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/form_field.dart/form_hader.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/farmer_controller.dart';
import 'farmer_edit_form.dart';
import 'model/farmer_list.dart';

class FarmerDetailView extends StatefulWidget {
  final Farmer farmer;
  final String? tag;
  const FarmerDetailView({required this.farmer, this.tag, super.key});

  @override
  State<FarmerDetailView> createState() => _FarmerDetailViewState();
}

class _FarmerDetailViewState extends State<FarmerDetailView> {
  final FarmerController _farmerController = Get.put(FarmerController());
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Farmer Details',
          style: AppTypography.kBold20.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FormImageHeader(
              tag: widget.tag ?? '',
              image: ImageDoctorUrl.farmerImage,
              header: widget.farmer.farmerName ?? '',
              subtitle: widget.farmer.promotionActivity ?? '',
            ),
            Positioned(
              top: 228.h,
              left: 20.w,
              right: 20.w,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Segment 1: Farmer's Basic Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: widget.farmer.farmerName ?? '',
                            fontSize: 20.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Promotion Activity",
                            value: widget.farmer.promotionActivity ?? '',
                          ),
                          InfoRow(
                            label: "Father's Name",
                            value: widget.farmer.fatherName ?? '',
                          ),
                          InfoRow(
                            label: "Mobile Number",
                            value: widget.farmer.mobileNo ?? '',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Segment 2: Farmer's Address Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: 'Address Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Village",
                            value: widget.farmer.villageName ?? '',
                          ),
                          InfoRow(
                            label: "Post Office",
                            value: widget.farmer.officeName ?? '',
                          ),
                          InfoRow(
                            label: "Sub-District",
                            value: widget.farmer.tehshil ?? '',
                          ),
                          InfoRow(
                            label: "District",
                            value: widget.farmer.district ?? '',
                          ),
                          InfoRow(
                            label: "State",
                            value: widget.farmer.state ?? '',
                          ),
                          InfoRow(
                            label: "PIN",
                            value: widget.farmer.pin ?? '',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Segment 3: Field Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: 'Field Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Acre",
                            value: widget.farmer.acre.toString(),
                          ),
                          InfoRow(
                            label: "Cows Count",
                            value: widget.farmer.cow.toString(),
                          ),
                          InfoRow(
                            label: "Buffalos Count",
                            value: widget.farmer.buffalo.toString(),
                          ),
                          InfoRow(
                            label: "Work Place Code",
                            value: widget.farmer.workplaceCode ?? '',
                          ),
                          InfoRow(
                            label: "Work Place Name",
                            value: widget.farmer.workplaceName ?? '',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FarmerActionSheet(
        editCallback: () {
          Get.to(() => FarmerEditForm(
                    farmer: widget.farmer,
                    tag: widget.farmer.mobileNo ?? '',
                  ))!
              .then((value) {
            Get.back();
          });
        },
        deleteCallback: () {
          _showConfirmationDialog(context);
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Confirm Action',
          content: 'Are you sure you want to proceed?',
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            _submitForm();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  //logic call function to delte and show api call loading, error dailog showw succcess dilog and refesh the list
  void _submitForm() {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
    try {
      _farmerController.deleteFarmer(widget.farmer.id);
    } catch (e) {
      Get.back();
      Get.dialog(
        ErrorDialog(
          errorMessage: e.toString(),
          onClose: () {
            Get.back();
          },
        ),
        barrierDismissible: false,
      );
    } finally {
      // Ensure loading dialog is closed
      Get.back(); // Close loading dialog if not already closed
    }
  }
}

class FarmerActionSheet extends StatelessWidget {
  final VoidCallback editCallback;
  final VoidCallback deleteCallback;
  const FarmerActionSheet({
    super.key,
    required this.editCallback,
    required this.deleteCallback,
  });
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: AppColors.kAccent1,
              onTap: deleteCallback,
              text: "Delete Farmer",
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: PrimaryButton(
              color: AppColors.kPrimary,
              onTap: editCallback,
              text: "Edit Farmer",
            ),
          ),
        ],
      ),
    );
  }
}
