// import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../data/constrants/constants.dart';
// import '../../widgets/components/Info_row_widget.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import '../formC/form_c_details_page.dart';
// import '../model/form_d_model.dart';
// import 'form_d_list_view.dart';

// class FormDDetailPage extends StatelessWidget {
//   final FormD formD;

//   const FormDDetailPage({super.key, required this.formD});
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
//           'Demonstration Details',
//           style: AppTypography.kBold14.copyWith(
//             color: isDarkMode(context)
//                 ? AppColors.kWhite
//                 : AppColors.kDarkContiner,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FormDCard(formD: formD),
//             SizedBox(height: 10.h),
//             _buildUserDetails(),
//             SizedBox(height: 10.h),
//             _buildFormDetails(),
//             SizedBox(height: 10.h),
//             CustomHeaderText(
//               text: 'Location',
//               fontSize: 18.sp,
//             ),
//             SizedBox(height: 10.h),
//             PrimaryContainer(
//               padding: EdgeInsets.all(12.h),
//               width: double.infinity, // Full width
//               margin: EdgeInsets.only(bottom: 10.h),
//               child: GestureDetector(
//                 onTap: () {
//                   String googleMapsUrl =
//                       "https://www.google.com/maps/search/?api=1&query=${formD.latitude},${formD.longitude}";
//                   launchUrl(Uri.parse(googleMapsUrl),
//                       mode: LaunchMode.externalApplication);
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     InfoRow(
//                       label: 'Latitude',
//                       value: formD.latitude,
//                     ),
//                     InfoRow(
//                       label: 'Longitude',
//                       value: formD.longitude,
//                     ),
//                     // show text to press go to the location with icons
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           color: AppColors.kPrimary,
//                         ),
//                         Text(
//                           'Press to go to the location',
//                           style: AppTypography.kBold12.copyWith(
//                             color: AppColors.kPrimary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (formD.remarks.isNotEmpty)
//               // BuildInfoCard(title: 'Remarks', content: formD.remarks),
//               SizedBox(height: 10.h),
//             if (formD.imageUrl.isNotEmpty)
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
//                           formD.imageUrl,
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
//                     formD.imageUrl,
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                     height: 200.h,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) {
//                         return child;
//                       }
//                       return const Center(child: CircularProgressIndicator());
//                     },
//                     errorBuilder: (context, error, stackTrace) {
//                       return const Center(
//                         child: Text('Failed to load image'),
//                       );
//                     },
//                   ),
//                 ),
//               ),
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
//               ...formD.formDUserDetails.map((userDetail) {
//                 return InfoRow(
//                   label: userDetail.partyName,
//                   value: userDetail.mobileNo,
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
//           text: 'Demo Details',
//           fontSize: 18.sp,
//         ),
//         SizedBox(height: 10.h),
//         ...formD.formDDetails.map((detail) {
//           return PrimaryContainer(
//             padding: EdgeInsets.all(12.h),
//             width: double.infinity, // Full width
//             margin: EdgeInsets.only(bottom: 10.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InfoRow(
//                   label: 'Crop',
//                   value: detail.cropName,
//                 ),
//                 //stage
//                 InfoRow(
//                   label: 'Stage',
//                   value: detail.cropStageName,
//                 ),
//                 InfoRow(
//                   label: 'Product',
//                   value: detail.productName,
//                 ),

//                 InfoRow(
//                   label: 'Pest',
//                   value: detail.pestName,
//                 ),
//                 InfoRow(
//                   label: 'Season',
//                   value: detail.seasonName,
//                 ),
//                 // New fields (only show if they are not null)
//                 if (detail.dosage != null)
//                   InfoRow(label: 'Dosage', value: detail.dosage!),
//                 if (detail.areaofdemo != null)
//                   InfoRow(label: 'Demo Area', value: detail.areaofdemo!),
//                 if (detail.totalarea != null)
//                   InfoRow(label: 'Total Area', value: detail.totalarea!),
//                 if (detail.expense != null)
//                   InfoRow(label: 'Expense', value: detail.expense!),
//               ],
//             ),
//           );
//         }),
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
import '../model/form_d_model.dart';
import 'form_d_list_view.dart';

class FormDDetailPage extends StatelessWidget {
  final FormD formD;

  const FormDDetailPage({super.key, required this.formD});

  String formDtDate(String dateStr) {
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
                  FormDCard(formD: formD),
                  SizedBox(height: 10.h),
                  _buildDetailCard(
                      "Activity Type", formD.promotionActivityType),
                  _buildDetailCard('Party Type', formD.partyType),
                  _buildDetailCard('Dosage', formD.dosages),
                  _buildDetailCard('Demo Area', formD.areaOfDemo),
                  _buildDetailCard('Total Acre of Farmers', formD.totalAreaCover),
                  _buildDetailCard('Value', formD.expense),
                  _buildDetailCard('Demo Date',
                      formDtDate(formD.activityPerformedDate)),
                  _buildDetailCard(
                      'Next Demo Date', formDtDate(formD.nextDemoDate)),
                  _buildDetailCard('Activity Performed Location',
                      formD.activityPerformedLocation),
                  _buildDetailCard('Remarks', formD.remarks),
                  SizedBox(height: 16.h),
                  _buildUserDetails(),
                  SizedBox(height: 16.h),
                  _buildTagSection('Season Details', formD.seasonDetails),
                  _buildTagSection('Product Details', formD.productDetails),
                  _buildTagSection('Crop Details', formD.cropDetails),
                  _buildTagSection('Crop Stage', formD.cropStageDetails),
                  _buildTagSection('Pest Details', formD.pestDetails),
                  if (formD.imageUrl.isNotEmpty) _buildImagePreview(),
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
            height: 140.h,
            color: AppColors.kPrimary.withValues(alpha: 0.9),
            child: Center(
              child: Text(
                'Demonstration Details',
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
            children: formD.formDUserDetails.map((userDetail) {
              //   return Padding(
              //     padding: EdgeInsets.symmetric(vertical: 5.h),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(
              //           child: Text(
              //             'Name: ${userDetail.partyName}',
              //             style: TextStyle(fontSize: 12.sp),
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //         if (userDetail.mobileNo.isNotEmpty)
              //           Expanded(
              //             child: Text(
              //               'Mobile: ${userDetail.mobileNo}',
              //               style: TextStyle(fontSize: 12.sp),
              //               overflow: TextOverflow.ellipsis,
              //               textAlign: TextAlign.right,
              //             ),
              //           ),
              //       ],
              //     ),
              //   );
              // }).toList(),

              return ListTile(
                leading: const Icon(Icons.person, color: Colors.green),
                title: Text(userDetail.partyName),
                subtitle: userDetail.mobileNo.isNotEmpty
                    ? Text("📞 ${userDetail.mobileNo}")
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.phone, color: Colors.blue),
                  onPressed: () {
                    if (userDetail.mobileNo.isNotEmpty) {
                      Get.snackbar("Calling", "Dialing ${userDetail.mobileNo}");
                      launchUrl(Uri(
                        scheme: 'tel',
                        path: userDetail.mobileNo,
                      ));
                    }
                  },
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
                  imageProvider: NetworkImage(formD.imageUrl),
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
                formD.imageUrl,
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
