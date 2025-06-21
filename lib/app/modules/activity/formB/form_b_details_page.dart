// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../data/constrants/constants.dart';
// import '../../widgets/containers/primary_container.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import '../formC/form_c_details_page.dart';
// import '../model/form_b_model.dart';
// import 'form_b_list_view.dart';

// class FormBDetailPage extends StatelessWidget {
//   final FormB formB;

//   const FormBDetailPage({super.key, required this.formB});

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
//             : AppColors.kPrimary.withAlpha(50),
//         title: Text(
//           'Campaign Details',
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
//             FormBCard(
//               formB: formB,
//             ),
//             SizedBox(height: 10.h),
//             _buildUserDetails(),
//             SizedBox(height: 10.h),
//             _buildFormDetails(),
//             SizedBox(height: 10.h),
//             if (formB.remarks != null)
//               BuildInfoCard(title: 'Remarks', content: formB.remarks!),
//           ],
//         ),
//       ),
//     );
//   }

//   // Builds the User Details section
//   Widget _buildUserDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomHeaderText(
//           text: 'Village Details',
//           fontSize: 18.sp,
//         ),
//         SizedBox(height: 10.h),
//         PrimaryContainer(
//           padding: EdgeInsets.all(12.h),
//           width: double.infinity, // Full width
//           margin: EdgeInsets.only(bottom: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ...formB.formBUserDetails.map((userDetail) {
//                 return Column(
//                   spacing: 5.h,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (userDetail.partyName.isNotEmpty)
//                       Row(
//                         children: [
//                           Icon(Icons.location_on,
//                               color: Colors.green, size: 16.sp),
//                           SizedBox(width: 8.w),
//                           Expanded(
//                             child: Text(
//                               userDetail.partyName,
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                     if (userDetail.routeName.isNotEmpty)
//                       Row(
//                         children: [
//                           Icon(Icons.route, color: Colors.blue, size: 16.sp),
//                           SizedBox(width: 8.w),
//                           Expanded(
//                             child: Text(
//                               userDetail.routeName,
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     // if(its last index dont shoe)
//                     if (formB.formBUserDetails.indexOf(userDetail) !=
//                         formB.formBUserDetails.length - 1)
//                       Divider(
//                         color: Colors.grey.shade300,
//                       ),
//                   ],
//                 );
//               }),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Builds the Form Details section
//   Widget _buildFormDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomHeaderText(
//           text: 'Campaign Details',
//           fontSize: 18.sp,
//         ),
//         SizedBox(height: 10.h),
//         ...formB.formBDetails.map((detail) {
//           return PrimaryContainer(
//             padding: EdgeInsets.all(12.h),
//             width: double.infinity, // Full width
//             margin: EdgeInsets.only(bottom: 10.h),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildDetailRow(
//                     Icons.shopping_bag, 'Product', detail.productName),
//                 _buildDetailRow(Icons.eco, 'Crop', detail.cropName),
//                 _buildDetailRow(Icons.timeline, 'Stage', detail.cropStageName),
//                 _buildDetailRow(Icons.bug_report, 'Pest', detail.pestName),
//                 _buildDetailRow(
//                     Icons.calendar_today, 'Season', detail.seasonName),
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }

// // Widget for reusable row with icon
//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 5.h),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.blue, size: 18.sp),
//           SizedBox(width: 10.w),
//           Expanded(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.blueGrey[700],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../model/form_b_model.dart';
import 'form_b_list_view.dart';

class FormBDetailPage extends StatelessWidget {
  final FormB formB;

  const FormBDetailPage({super.key, required this.formB});

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
                  FormBCard(formB: formB),
                  SizedBox(height: 10.h),
                  _buildDetailCard(
                      "Activity Type", formB.promotionActivityType),
                  _buildDetailCard('Party Type', formB.partyType),
                  _buildDetailCard('Activity Performed Date',
                      formatDate(formB.activityPerformedDate)),
                  _buildDetailCard('Activity Performed Location',
                      formB.activityPerformedLocation),
                  _buildDetailCard('Remarks', formB.remarks),
                  SizedBox(height: 16.h),
                  _buildUserDetails(),
                  SizedBox(height: 16.h),
                  _buildRouteDetails(),
                  SizedBox(height: 16.h),
                  _buildTagSection('Season Details', formB.seasonDetails),
                  _buildTagSection('Product Details', formB.productDetails),
                  _buildTagSection('Crop Details', formB.cropDetails),
                  _buildTagSection('Crop Stage', formB.cropStageDetails),
                  _buildTagSection('Pest Details', formB.pestDetails),
                  if (formB.imageUrl.isNotEmpty) _buildImagePreview(),
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
                'Jeep Campaign Details',
                style: AppTypography.kBold16.copyWith(color: Colors.white),
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

  Widget _buildTagSection(String title, List<String> items) {
    return items.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Text(
                  title,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: items
                    .map(
                      (item) => Chip(
                        label: Text(item, style: TextStyle(fontSize: 12.sp)),
                        backgroundColor:
                            AppColors.kPrimary.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 10.h),
            ],
          )
        : SizedBox.shrink();
  }

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderText(text: 'Party Details', fontSize: 18.sp),
        SizedBox(height: 10.h),
        PrimaryContainer(
          padding: EdgeInsets.all(12.h),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: formB.formBUserDetails.map((userDetail) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Name: ${userDetail.partyName}',
                        style: TextStyle(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (userDetail.mobileNo.isNotEmpty)
                      Expanded(
                        child: Text(
                          'Mobile: ${userDetail.mobileNo}',
                          style: TextStyle(fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRouteDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeaderText(text: 'Route Details', fontSize: 18.sp),
        SizedBox(height: 10.h),
        PrimaryContainer(
          padding: EdgeInsets.all(12.h),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: formB.routeDetails.map((name) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Name: $name',
                        style: TextStyle(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
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
                  imageProvider: NetworkImage(formB.imageUrl),
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
          CustomHeaderText(text: 'Image Preview', fontSize: 18.sp),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r)),
            elevation: 3,
            margin: EdgeInsets.only(top: 10.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                formB.imageUrl,
                fit: BoxFit.contain,
                height: 200.h,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
