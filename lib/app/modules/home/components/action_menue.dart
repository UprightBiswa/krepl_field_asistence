import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';

class ActionMenuIcon extends StatelessWidget {
  final Function onEdit;
  final Function onDelete;

  const ActionMenuIcon({
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColors.kBackground,
      icon: PrimaryContainer(
        padding: EdgeInsets.all(12.h),
        color: AppColors.kPrimary.withOpacity(0.08),
        child: const Icon(
          Icons.more_vert,
          color: AppColors.kWhite,
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: 'edit',
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              onEdit();
            },
          ),
        ),
        // const PopupMenuDivider(),
        // PopupMenuItem(
        //   value: 'delete',
        //   child: ListTile(
        //     leading: const Icon(Icons.delete),
        //     title: const Text('Delete'),
        //     onTap: () {
        //       onDelete();
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
      ],
    );
  }
}
