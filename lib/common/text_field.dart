import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    required this.controller,
    required this.hint,
    this.readOnly,
    super.key,
    this.trailing,
    this.onTapped,
    this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final Widget? icon;
  final Widget? trailing;
  final void Function()? onTapped;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.all(context.screenWidth * 0.01869158878),
      child: Row(
        children: [
          if (icon != null) ...[
            icon!,
          ],
          SizedBox(
            width: context.screenWidth * 0.02803738317,
          ),
          Expanded(
            child: TextFormField(
              onTap: onTapped,
              readOnly: readOnly ?? false,
              controller: controller,
              decoration: InputDecoration.collapsed(
                hintStyle: const TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: 14,
                ),
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: hint,
              ),
            ),
          ),
          SizedBox(
            width: context.screenWidth * 0.02803738317,
          ),
          if (trailing != null) ...[
            trailing!,
          ],
        ],
      ),
    );
  }
}
