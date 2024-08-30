import 'package:field_asistence/app/modules/widgets/buttons/buttons.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';

class ActivityErrorView extends StatelessWidget {
  final VoidCallback onTap;
  const ActivityErrorView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      width: double.infinity,
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            size: 50,
          ),
          const Text(
            'No Data Found',
            style: TextStyle(fontSize: 20),
          ),
          //add primaray buttion and call back function retey
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(onTap: onTap, text: 'Retry'),
        ],
      ),
    );
  }
}
