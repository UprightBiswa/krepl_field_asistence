import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/doctor_list.dart';
import 'doctor_list_card.dart';

class FarmerListView extends StatelessWidget {
  final List<Farmer> farmers;

  const FarmerListView({super.key, required this.farmers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return FarmerListCard(
            farmer: farmers[index],
            index: index,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 20.w),
        itemCount: farmers.length,
      ),
    );
  }
}