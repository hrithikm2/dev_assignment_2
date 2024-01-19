import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    required this.controller,
    required this.hint,
    super.key,
  });
  final TextEditingController controller;
  final String hint;

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
          const Icon(
            Icons.person_outline,
            color: AppColors.appMainColor,
          ),
          SizedBox(
            width: context.screenWidth * 0.02803738317,
          ),
          Expanded(
            child: TextFormField(
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
        ],
      ),
    );
  }
}
