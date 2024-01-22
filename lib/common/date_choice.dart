import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';

class DateChoice extends StatelessWidget {
  const DateChoice({
    required this.label,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });
  final String label;
  final bool isSelected;

  // ignore: avoid_positional_boolean_parameters
  final void Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      backgroundColor: AppColors.lightBlue,
      showCheckmark: false,
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      selectedColor: AppColors.mainColor,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      label: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: context.screenWidth * 0.40654205607),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.mainColor,
            ),
          ),
        ),
      ),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}
