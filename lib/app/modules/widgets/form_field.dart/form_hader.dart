import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FormImageHeader extends StatelessWidget {
  //string image, hadder name, subtitle
  final String image;
  final String header;
  final String subtitle;
  final String tag;

  const FormImageHeader({
    super.key,
    required this.image,
    required this.header,
    required this.subtitle,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        height: 270.h,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 270.h,
              width: Get.width,
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       header,
              //       style: TextStyle(
              //         fontSize: 24.sp,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //     Text(
              //       subtitle,
              //       style: TextStyle(
              //         fontSize: 18.sp,
              //         color: Colors.white.withOpacity(0.7),
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
