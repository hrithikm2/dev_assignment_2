import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CommonFunctions {
  static void showSnackbar(
    BuildContext context,
    String content, {
    void Function()? onTap,
    String? buttonLabel,
    void Function()? onClosed,
  }) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            action: (buttonLabel != null)
                ? SnackBarAction(
                    label: buttonLabel,
                    textColor: AppColors.mainColor,
                    onPressed: onTap!,
                  )
                : null,
            content: Text(content),
          ),
        )
        .closed
        .then((value) => onClosed?.call());
  }
}
