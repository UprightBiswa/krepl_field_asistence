// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../data/constrants/constants.dart';
// import '../../widgets/containers/primary_container.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import '../model/form_a_model.dart';
// import 'form_a_list_view.dart';

// class FormADetailPage extends StatelessWidget {
//   final FormA formA;

//   const FormADetailPage({super.key, required this.formA});

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
//             : AppColors.kPrimary.withOpacity(0.15),
//         title: Text(
//           'Activity Details',
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
//             FormACard(formA: formA),
//             SizedBox(height: 10.h),
//             _buildUserDetails(),
//             SizedBox(height: 10.h),
//             _buildFormDetails(),
//             SizedBox(height: 10.h),
//             if (formA.remarks.isNotEmpty)
//               BuildInfoCard(title: 'Remarks', content: formA.remarks),
//             SizedBox(height: 10.h),
//             if (formA.imageUrl.isNotEmpty)
//               GestureDetector(
//                 onTap: () {
//                   //open a dialog show image and user can zoom
//                   Get.dialog(
//                     Dialog(
//                       backgroundColor: Colors.transparent,
//                       surfaceTintColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: double.infinity,
//                         child: Image.network(
//                           formA.imageUrl,
//                           fit: BoxFit.contain,
//                           width: double.infinity,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 child: PrimaryContainer(
//                   padding: EdgeInsets.symmetric(vertical: 10.h),
//                   child: Image.network(
//                     formA.imageUrl,
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                     height: 200.h,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFormDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomHeaderText(
//           text: 'Activity Details',
//           fontSize: 18.sp,
//         ),
//         SizedBox(height: 10.h),
//         ...formA.formADetails.map((detail) {
//           return FormDetailsCard(detail: detail);
//         }),
//       ],
//     );
//   }

// // Builds the User Details section
//   Widget _buildUserDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomHeaderText(
//           text: 'Party Details',
//           fontSize: 18.sp,
//         ),
//         SizedBox(height: 10.h),
//         PrimaryContainer(
//           padding: EdgeInsets.all(12.h),
//           width: double.infinity, // Full width
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ...formA.formAUserDetails.map((userDetail) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(vertical: 5.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Party Name: ${userDetail.partyName}',
//                         style: TextStyle(fontSize: 12.sp),
//                       ),
//                       if (userDetail.mobileNo.isNotEmpty)
//                         Text(
//                           'Mobile: ${userDetail.mobileNo}',
//                           style: TextStyle(fontSize: 12.sp),
//                         ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ],
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

// class FormDetailsCard extends StatelessWidget {
//   final FormADetails detail;

//   const FormDetailsCard({
//     super.key,
//     required this.detail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PrimaryContainer(
//       padding: EdgeInsets.all(12.h),
//       width: double.infinity,
//       margin: EdgeInsets.only(bottom: 10.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildRow('Crop:', detail.cropName),
//           _buildRow('Stage:', detail.cropStageName),
//           _buildRow('Product:', detail.productName),
//           _buildRow('Pest:', detail.pestName),
//           _buildRow('Season:', detail.seasonName),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(label, style: TextStyle(fontSize: 12.sp)),
//         Text(value, style: TextStyle(fontSize: 12.sp)),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../data/constrants/constants.dart';
// import '../../widgets/containers/primary_container.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import '../model/form_a_model.dart';
// import 'form_a_list_view.dart';

// class FormADetailPage extends StatelessWidget {
//   final FormA formA;

//   const FormADetailPage({super.key, required this.formA});

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
//             : AppColors.kPrimary.withOpacity(0.15),
//         title: Text(
//           'Activity Details',
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
//             FormACard(formA: formA),
//             SizedBox(height: 16.h),
//             _buildUserDetails(),
//             SizedBox(height: 16.h),
//             _buildFormDetails(),
//             SizedBox(height: 16.h),
//             if (formA.remarks.isNotEmpty)
//               BuildInfoCard(title: 'Remarks', content: formA.remarks),
//             SizedBox(height: 16.h),
//             if (formA.imageUrl.isNotEmpty) _buildImagePreview(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImagePreview(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.dialog(
//           Dialog(
//             backgroundColor: Colors.transparent,
//             child: InteractiveViewer(
//               panEnabled: true,
//               minScale: 0.5,
//               maxScale: 4.0,
//               child: Image.network(
//                 formA.imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         );
//       },
//       child: PrimaryContainer(
//         padding: EdgeInsets.symmetric(vertical: 10.h),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10.r),
//           child: Image.network(
//             formA.imageUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: 200.h,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFormDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomHeaderText(
//           text: 'Activity Details',
//           fontSize: 18.sp,
//         ),
//         SizedBox(height: 10.h),
//         ...formA.formAUserDetails.map((detail) {
//           return FormDetailsCard(detail: detail);
//         }).toList(),
//       ],
//     );
//   }

//   Widget _buildUserDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomHeaderText(
//           text: 'Party Details',
//           fontSize: 18.sp,
//         ),
//         SizedBox(height: 10.h),
//         PrimaryContainer(
//           padding: EdgeInsets.all(12.h),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: formA.formAUserDetails.map((userDetail) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(vertical: 5.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         'Party Name: ${userDetail.partyName}',
//                         style: TextStyle(fontSize: 12.sp),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     if (userDetail.mobileNo.isNotEmpty)
//                       Expanded(
//                         child: Text(
//                           'Mobile: ${userDetail.mobileNo}',
//                           style: TextStyle(fontSize: 12.sp),
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.right,
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
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
//       width: double.infinity,
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

// class FormDetailsCard extends StatelessWidget {
//   final FormAUserDetails detail;

//   const FormDetailsCard({super.key, required this.detail});

//   @override
//   Widget build(BuildContext context) {
//     return PrimaryContainer(
//       padding: EdgeInsets.all(12.h),
//       width: double.infinity,
//       margin: EdgeInsets.only(bottom: 10.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildRow('Party Name:', detail.partyName),
//           _buildRow('Mobile:', detail.mobileNo),
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 3.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: TextStyle(fontSize: 12.sp)),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(fontSize: 12.sp),
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.right,
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
import '../model/form_a_model.dart';
import 'form_a_list_view.dart';

class FormADetailPage extends StatelessWidget {
  final FormA formA;

  const FormADetailPage({super.key, required this.formA});

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

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
                  FormACard(formA: formA),
                  SizedBox(height: 10.h),
                  _buildDetailCard(
                      "Activity Type", formA.promotionActivityType),
                  _buildDetailCard('Party Type', formA.partyType),
                  _buildDetailCard('Expense', formA.expense),
                  _buildDetailCard('Activity Performed Date',
                      formatDate(formA.activityPerformedDate)),
                  _buildDetailCard('Activity Performed Location',
                      formA.activityPerformedLocation),
                  _buildDetailCard('Remarks', formA.remarks),
                  SizedBox(height: 16.h),
                  _buildUserDetails(),
                  SizedBox(height: 16.h),
                  _buildTagSection('Season Details', formA.seasonDetails),
                  _buildTagSection('Product Details', formA.productDetails),
                  _buildTagSection('Crop Details', formA.cropDetails),
                  _buildTagSection('Crop Stage', formA.cropStageDetails),
                  _buildTagSection('Pest Details', formA.pestDetails),
                  if (formA.imageUrl.isNotEmpty) _buildImagePreview(),
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
            color: AppColors.kPrimary.withOpacity(0.9),
            child: Center(
              child: Text(
                'Activity Details',
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

  Widget _buildUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: formA.formAUserDetails.map((userDetail) {
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
                        backgroundColor: AppColors.kPrimary.withOpacity(0.1),
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
                  imageProvider: NetworkImage(formA.imageUrl),
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
                formA.imageUrl,
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

// Custom Clipper for Modern Header
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
