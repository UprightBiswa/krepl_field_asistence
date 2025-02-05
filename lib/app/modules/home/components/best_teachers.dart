// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../data/constrants/constants.dart';
// import '../../dashboard/model/cutomer _sales_data.dart';
// import '../../onboarding_scrrens/components/custom_indicator.dart';
// import 'best_teachers_card.dart';

// class BestTeachers extends StatefulWidget {
//   const BestTeachers({super.key});

//   @override
//   State<BestTeachers> createState() => _BestTeachersState();
// }

// class _BestTeachersState extends State<BestTeachers> {
//   late PageController _pageController;
//   final int _currentPage = 1;

//   @override
//   void initState() {
//     super.initState();
//     _pageController =
//         PageController(initialPage: _currentPage, viewportFraction: 0.57);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _pageController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           'Customer Sales',
//           style: AppTypography.kBold16,
//         ),
//         SizedBox(height: AppSpacing.tenHorizontal),
//         SizedBox(
//           height: 260.h,
//           child: PageView.builder(
//             itemCount: dummySalesYTDData.length,
//             clipBehavior: Clip.none,
//             physics: const BouncingScrollPhysics(),
//             controller: _pageController,
//             itemBuilder: (context, index) {
//               return BestTeachersCard(
//                 index: index,
//                 pageController: _pageController,
//                 dummySalesYTDData: dummySalesYTDData[index],
//               );
//             },
//           ),
//         ),
//         SizedBox(height: 20.h),
//         CustomIndicator(
//           controller: _pageController,
//           dotsLength: 3,
//         ),
//       ],
//     );
//   }
// }
