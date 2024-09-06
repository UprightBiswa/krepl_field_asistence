import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../../widgets/texts/custom_header_text.dart';

class ExpandedObject extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final Function onDismissed;
  final bool isExpanded;
  final Function(bool)? onExpansionChanged;

  const ExpandedObject({
    super.key,
    required this.title,
    required this.children,
    required this.onDismissed,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  State<ExpandedObject> createState() => _ExpandedObjectState();
}

class _ExpandedObjectState extends State<ExpandedObject> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryContainer(
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ListTileTheme(
              dense: true, // Adjust padding and spacing for a denser layout
              child: Slidable(
                key: const ValueKey(0), // Unique key for Slidable
                startActionPane: ActionPane(
                  // Define slide actions
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      label: 'Delete', // Label for the delete action
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors
                          .kAccent1, // Custom color for delete background
                      icon: Icons.delete,
                      onPressed: (context) {
                        widget
                            .onDismissed(); // Trigger the delete function when sliding
                      },
                    ),
                  ],
                ),
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    setState(() {
                      isExpanded = value;
                    });
                    if (widget.onExpansionChanged != null) {
                      widget.onExpansionChanged!(value);
                    }
                  },
                  initiallyExpanded: isExpanded,
                  childrenPadding: EdgeInsets.zero,
                  tilePadding: EdgeInsets.zero,
                  title: CustomHeaderText(
                    text: widget.title,
                    fontSize: 18.sp,
                  ),
                  children: widget.children,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
