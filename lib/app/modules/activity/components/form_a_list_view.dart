import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/containers/primary_container.dart';
import '../model/form_a_model.dart';

class FormAListView extends StatelessWidget {
  final RxList<FormAModel> formAList;

  const FormAListView({super.key, required this.formAList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: formAList.length,
      itemBuilder: (context, index) {
        return FormACard(formA: formAList[index]);
      },
    );
  }
}

class FormACard extends StatelessWidget {
  final FormAModel formA;

  const FormACard({super.key, required this.formA});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      width: double.infinity,
      padding: EdgeInsets.all(10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formA.farmerVillageDoctorName,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text('Party Type: ${formA.partyType}',
              style: TextStyle(fontSize: 12.sp)),
          Text('Mobile: ${formA.mobileNumber}',
              style: TextStyle(fontSize: 12.sp)),
          Text('Season: ${formA.season}', style: TextStyle(fontSize: 12.sp)),
          Text('Crop: ${formA.crop}', style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
