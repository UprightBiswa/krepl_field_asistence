// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'package:field_asistence/app/modules/activity/model/form_c_model.dart';

// import '../../../data/constrants/constants.dart';
// import '../../widgets/components/Info_row_widget.dart';
// import '../../widgets/containers/primary_container.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import 'form_c_list_view.dart';

// class FormCDetailPage extends StatelessWidget {
//   final FormC formC;

//   const FormCDetailPage({super.key, required this.formC});

//   bool isDarkMode(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomBackAppBar(
//         spaceBar: true,
//         leadingCallback: () {
//           Get.back<void>();
//         },
//         iconColor: isDarkMode(context)
//             ? Colors.black
//             : AppColors.kPrimary.   withValues(alpha:0.15),
//         title: Text(
//           'Dealer Stock Details',
//           style: AppTypography.kBold14.copyWith(
//             color: isDarkMode(context)
//                 ? AppColors.kWhite
//                 : AppColors.kDarkContiner,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FormCCard(
//               formC: formC,
//             ),
//             SizedBox(height: 10.h),
//             if (formC.retailers.isNotEmpty) ...[
//               CustomHeaderText(
//                 text: 'User Details',
//                 fontSize: 18.sp,
//               ),
//               SizedBox(height: 10.h),
//               PrimaryContainer(
//                 child: Column(children: [
//                   for (var retailer in formC.retailers)
//                     InfoRow(
//                       label: retailer.name,
//                       value: retailer.mobile,
//                     )
//                 ]),
//               ),
//               SizedBox(height: 10.h),
//             ],
//             CustomHeaderText(
//               text: 'Stock Details',
//               fontSize: 18.sp,
//             ),
//             SizedBox(height: 10.h),
//             ...formC.formCDetails.map(
//               (detail) => Padding(
//                 padding: EdgeInsets.only(bottom: 16.h),
//                 child: _FormCDetailCard(detail: detail),
//               ),
//             ),
//             if (formC.remarks.isNotEmpty)
//               BuildInfoCard(title: 'Remarks', content: formC.remarks),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BuildInfoCard extends StatelessWidget {
//   final String title;
//   final String content;

//   const BuildInfoCard({
//     super.key,
//     required this.title,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PrimaryContainer(
//       padding: EdgeInsets.all(12.h),
//       width: double.infinity, // Full width
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 5.h),
//           Text(content, style: TextStyle(fontSize: 12.sp)),
//         ],
//       ),
//     );
//   }
// }

// //class for RetaielerCard extends StatelessWidget {
// class RetaielerCard extends StatelessWidget {
//   final Retailer retailer;

//   const RetaielerCard({super.key, required this.retailer});

//   @override
//   Widget build(BuildContext context) {
//     return PrimaryContainer(
//       padding: EdgeInsets.all(16.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _detailRow(label: 'Retailer Name', value: retailer.name),
//           _detailRow(label: 'Mobile', value: retailer.mobile),
//         ],
//       ),
//     );
//   }

//   _detailRow({required String label, required String value}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//         ),
//         Text(value, style: TextStyle(fontSize: 12.sp)),
//       ],
//     );
//   }
// }

// class _FormCDetailCard extends StatelessWidget {
//   final FormCDetail detail;

//   const _FormCDetailCard({required this.detail});

//   @override
//   Widget build(BuildContext context) {
//     return PrimaryContainer(
//       padding: EdgeInsets.all(16.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (detail.productName.isNotEmpty)
//             _detailRow(label: 'Product Name', value: detail.productName),
//           if (detail.quantity.isNotEmpty)
//             _detailRow(label: 'Quantity', value: detail.quantity),
//           if (detail.expense.isNotEmpty)
//             _detailRow(label: 'Expense', value: detail.expense),
//         ],
//       ),
//     );
//   }

//   _detailRow({required String label, required String value}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//         ),
//         Text(value, style: TextStyle(fontSize: 12.sp)),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../formA/form_a_details_page.dart';
import '../model/form_c_model.dart';
import 'form_c_list_view.dart';

class FormCDetailPage extends StatelessWidget {
  final FormC formC;

  const FormCDetailPage({super.key, required this.formC});

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormCCard(formC: formC),
                  SizedBox(height: 10.h),
                  _buildDetailCard(
                      "Promotion Type", formC.promotionActivityType),
                  _buildDetailCard('Party Type', formC.partyType),
                  _buildDetailCard('Value', formC.expense),
                  _buildDetailCard('Activity Performed Date',
                      formatDate(formC.activityPerformedDate)),
                  _buildDetailCard('Activity Performed Location',
                      formC.activityPerformedLocation),
                  _buildDetailCard('Remarks', formC.remarks),
                  SizedBox(height: 10.h),
                  _buildRetailersList(),
                  SizedBox(height: 10.h),
                  _buildProductDetails(),
                  SizedBox(height: 10.h),
                  if (formC.imageUrl.isNotEmpty) _buildImagePreview(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            width: double.infinity,
            height: 200.h,
            color: AppColors.kPrimary.withValues(alpha: 0.9),
            child: Center(
              child: Text(
                'Dealer Stock Details',
                style: AppTypography.kBold16.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 40.h,
          left: 10.w,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back<void>(),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailCard(String title, String value) {
    return value.isNotEmpty
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            elevation: 3,
            margin: EdgeInsets.only(bottom: 10.h),
            child: Padding(
              padding: EdgeInsets.all(12.h),
              child: Row(
                children: [
                  Icon(Icons.info, color: AppColors.kPrimary),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      '$title: $value',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }

  // Widget to show product details
  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderText(
          text: 'Product Details',
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: formC.productDetails
              .map(
                (product) => Chip(
                  backgroundColor: AppColors.kPrimary.withValues(alpha: 0.1),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_bag, color: AppColors.kPrimary),
                      SizedBox(width: 10.w),
                      Text(product, style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // Widget to show retailer list
  Widget _buildRetailersList() {
    return Column(
      children: [
        CustomHeaderText(
          text: 'Party Details',
          fontSize: 18.sp,
        ),
        SizedBox(height: 10.h),
        PrimaryContainer(
          padding: EdgeInsets.all(12.h),
          width: double.infinity,
          child: Column(
            children: [
              ...formC.retailers.map(
                (retailer) => ListTile(
                  leading: const Icon(Icons.person, color: Colors.green),
                  title: Text(retailer.retailerName),
                  subtitle: Text("📞 ${retailer.phoneNo}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone, color: Colors.blue),
                    onPressed: () {
                      Get.snackbar("Calling", "Dialing ${retailer.phoneNo}");
                      launchUrl(Uri(
                        scheme: 'tel',
                        path: retailer.phoneNo,
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          Dialog(
            backgroundColor: Colors.transparent,
            child: PhotoViewGallery.builder(
              itemCount: 1,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(formC.imageUrl),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              scrollPhysics: BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
            ),
          ),
        );
      },
      child: Column(
        children: [
          CustomHeaderText(
            text: 'Image Preview',
            fontSize: 18.sp,
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r)),
            elevation: 3,
            margin: EdgeInsets.only(top: 10.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                formC.imageUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
