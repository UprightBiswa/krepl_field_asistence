import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/route_list.dart';

class RouteActionMenu extends StatelessWidget {
  final RouteStatus status;
  final Function onActivate;
  final Function onDeactivate;
  final Function onDelete;

  const RouteActionMenu({
    required this.status,
    required this.onActivate,
    required this.onDeactivate,
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
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry> menuItems = [];
        
        if (status == RouteStatus.Active) {
          menuItems.add(
            PopupMenuItem(
              value: 'deactivate',
              child: ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Deactivate'),
                onTap: () {
                  onDeactivate();
                  Navigator.pop(context);
                },
              ),
            ),
          );
        } else if (status == RouteStatus.Deactive) {
          menuItems.add(
            PopupMenuItem(
              value: 'activate',
              child: ListTile(
                leading: const Icon(Icons.check_circle),
                title: const Text('Activate'),
                onTap: () {
                  onActivate();
                  Navigator.pop(context);
                },
              ),
            ),
          );
        }

        menuItems.add(
          PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                onDelete();
                Navigator.pop(context);
              },
            ),
          ),
        );

        return menuItems;
      },
    );
  }
}
