import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';

class ActionMenuIcon extends StatelessWidget {
  final Function? onEdit;
  final Function? onDelete;

  const ActionMenuIcon({
    this.onEdit,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: PrimaryContainer(
        padding: EdgeInsets.all(12.h),
        color: AppColors.kPrimary.withValues(alpha: 0.08),
        child: const Icon(
          Icons.more_vert,
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        if (onEdit != null)
          PopupMenuItem(
            value: 'edit',
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                onEdit!();
              },
            ),
          ),
        if (onDelete != null)
          PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                onDelete!();
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
