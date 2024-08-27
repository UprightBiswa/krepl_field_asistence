import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/doctor_list.dart';
import 'doctor_list_card.dart';

class DoctorListView extends StatelessWidget {
  final List<Doctor> doctors;

  const DoctorListView({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return DoctorListCard(
            doctor: doctors[index],
            index: index,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 20.w),
        itemCount: doctors.length,
      ),
    );
  }
}
