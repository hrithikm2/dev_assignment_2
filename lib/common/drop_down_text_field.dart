import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownTextField extends StatelessWidget {
  const DropDownTextField({required this.items, required this.hint, super.key});
  final List<DropdownMenuItem<String>> items;
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
            Icons.work_outline,
            color: AppColors.appMainColor,
          ),
          SizedBox(
            width: context.screenWidth * 0.02803738317,
          ),
          Expanded(
            child: DropdownButtonFormField2(
              items: items,
              hint: Text(
                hint,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.hintTextColor,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                elevation: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.appMainColor,
                ),
              ),
              decoration: InputDecoration.collapsed(
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: hint,
              ),
              onChanged: (String? value) {},
            ),
          ),
        ],
      ),
    );
  }
}
