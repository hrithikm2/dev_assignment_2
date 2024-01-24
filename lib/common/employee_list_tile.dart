import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile({
    required this.employeeName,
    required this.employeeRole,
    required this.employeeDuration,
    super.key,
    this.onDiscard,
    this.onTap,
  });
  final String employeeName;
  final String employeeRole;
  final String employeeDuration;
  final void Function(BuildContext)? onDiscard;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const StretchMotion(),
        // A pane can dismiss the Slidable.
        //dismissible: DismissiblePane(onDismissed: onDismissed),
        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: onDiscard,
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            icon: Icons.delete,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                employeeName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Gap(6),
              Text(
                employeeRole,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.hintTextColor,
                ),
              ),
              const Gap(6),
              Text(
                employeeDuration,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.hintTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
