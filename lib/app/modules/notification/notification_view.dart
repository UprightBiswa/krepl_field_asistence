import 'package:field_asistence/app/modules/widgets/appbars/appbars.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/constrants/constants.dart';
import '../../repository/firebase/notification_db.dart';
import '../../repository/firebase/notification_model.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/texts/custom_header_text.dart';
import 'components/notifaication_card.dart';

class NotificationView extends StatefulWidget {
  final bool? showappbar;
  const NotificationView({super.key, this.showappbar});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late Future<List<NotificationModel>> _notifications;
  bool _isAscending = false;
  @override
  void initState() {
    super.initState();
    _notifications = NotificationDatabase().fetchNotifications();
  }

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
      _notifications =
          NotificationDatabase().fetchNotifications().then((notifications) {
        notifications.sort((a, b) => _isAscending
            ? a.notificationTime.compareTo(b.notificationTime)
            : b.notificationTime.compareTo(a.notificationTime));
        return notifications;
      });
    });
  }

  void _deleteNotification(String id) async {
    await NotificationDatabase().deleteNotification(id);
    setState(() {
      _notifications = NotificationDatabase().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showappbar!
          ? CustomBackAppBar(
              leadingCallback: () => Navigator.pop(context),
              title: const Text('Notifications'),
              centerTitle: true,
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: !widget.showappbar! ? preferredSize.height : 0),
          FutureBuilder<List<NotificationModel>>(
            future: _notifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error fetching notifications'));
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Padding(
                    padding:
                        EdgeInsets.only(top: 200.h, left: 10.w, right: 10.w),
                    child: PrimaryContainer(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AppAssets.kNotifications,
                            size: 100.w,
                            color: AppColors.kPrimary,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'No Notifications!',
                            style: AppTypography.kMedium16.copyWith(),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'You dont have any notification yet.',
                            style: AppTypography.kBold12.copyWith(),
                          ),
                        ],
                      ),
                    ));
              } else {
                final notificationsList = snapshot.data!;
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.tenHorizontal),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          const CustomHeaderText(text: 'Notifications'),
                          const Spacer(),
                          CustomButton(
                            //old new  data soring date time old new sort order
                            text: _isAscending
                                ? 'Sort Ascending'
                                : 'Sort Descending', //old new
                            icon: _isAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            onTap: _toggleSortOrder,
                            isBorder: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      PrimaryContainer(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    label: 'Delete',
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.kAccent1,
                                    icon: Icons.delete,
                                    onPressed: (context) {
                                      _deleteNotification(
                                          notificationsList[index].id);
                                    },
                                  ),
                                ],
                              ),
                              child: NotificationCard(
                                index: index,
                                notification: notificationsList[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: notificationsList.length,
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
