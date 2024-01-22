import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({required this.onPressed, super.key});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColors.lightBlue,
      height: context.screenHeight * 0.043,
      minWidth: context.screenWidth * 0.17,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onPressed: onPressed,
      child: Text(
        context.l10n.cancelButtonText,
        style: const TextStyle(color: AppColors.mainColor),
      ),
    );
  }
}
