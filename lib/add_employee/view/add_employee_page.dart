import 'package:dev_assignment_2/add_employee/cubit/add_employee_cubit.dart';
import 'package:dev_assignment_2/common/cancel_button.dart';
import 'package:dev_assignment_2/common/date_choice.dart';
import 'package:dev_assignment_2/common/save_button.dart';
import 'package:dev_assignment_2/common/text_field.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_cubit.dart';
import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/app_assets.dart';
import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/app_enums.dart';
import 'package:dev_assignment_2/utils/common_functions.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:table_calendar/table_calendar.dart';

part 'widgets/bottom_sheet.dart';
part 'widgets/date_picker_dialog.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key, this.isEdit = false});
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return AddEmployeeView(
      isEdit: isEdit,
    );
  }
}

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({required this.isEdit, super.key});
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<AddEmployeeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addEmployeeAppBarTitle),
        automaticallyImplyLeading: false,
        actions: isEdit
            ? [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppAssets.deleteIcon),
                ),
              ]
            : null,
      ),
      body: BlocConsumer<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is RequestedDatePicker) {
            if (state.isValid) {
              if (state.isStart) {
                showDialog<dynamic>(
                  context: context,
                  builder: (_) => DatePickerDialog(
                    cubit: cubit,
                    isStart: true,
                    options: [
                      (DateOption.today, context.l10n.today),
                      (DateOption.nextMonday, context.l10n.nextMonday),
                      (DateOption.nextTuesday, context.l10n.nextTuesday),
                      (DateOption.afterOneWeek, context.l10n.afterOneWeek),
                    ],
                    onSaved: () => cubit.saveDate(
                      cubit.startDateController,
                      cubit.selectedStartDate,
                    ),
                  ),
                );
              } else {
                showDialog<dynamic>(
                  context: context,
                  builder: (_) => DatePickerDialog(
                    isStart: false,
                    cubit: cubit,
                    options: [
                      (DateOption.noDate, context.l10n.noDate),
                      (DateOption.today, context.l10n.today),
                    ],
                    onSaved: () => cubit.saveDate(
                      cubit.endDateController,
                      cubit.selectedEndDate,
                    ),
                  ),
                );
              }
            } else {
              CommonFunctions.showSnackbar(
                context,
                context.l10n.selectDateAlert,
              );
            }
          } else if (state is AddEmployeeInvalid) {
            CommonFunctions.showSnackbar(
              context,
              context.l10n.fillAllFieldsAlert,
            );
          } else if (state is AddEmployeeSuccess) {
            context
                .read<EmployeeListCubit>()
                .currentEmployees
                .add(cubit.employee);
            context.pop;
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(context.screenWidth * 0.03738317757),
            child: Column(
              children: [
                //Name
                DefaultTextField(
                  controller: cubit.nameController,
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.mainColor,
                  ),
                  hint: context.l10n.employeeNameHint,
                ),
                SizedBox(
                  height: context.screenHeight * 0.02483801295,
                ),

                //Role
                DefaultTextField(
                  hint: context.l10n.selectRoleHint,
                  icon: const Icon(
                    Icons.work_outline,
                    color: AppColors.mainColor,
                  ),
                  controller: cubit.roleController,
                  readOnly: true,
                  onTapped: () => showModalBottomSheet<String>(
                    context: context,
                    backgroundColor: AppColors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    builder: (_) => BottomSheet(
                      cubit: cubit,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.screenHeight * 0.02483801295,
                ),

                //Dates
                Row(
                  children: [
                    Expanded(
                      child: DefaultTextField(
                        controller: cubit.startDateController,
                        icon: SvgPicture.asset(
                          AppAssets.calendarIcon,
                        ),
                        hint: context.l10n.noDate,
                        readOnly: true,
                        onTapped: () => cubit.onDatePickerTapped(
                          isValid: true,
                          isStart: true,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.east,
                        size: 20,
                        color: AppColors.mainColor,
                      ),
                    ),
                    Expanded(
                      child: DefaultTextField(
                        controller: cubit.endDateController,
                        icon: SvgPicture.asset(
                          AppAssets.calendarIcon,
                        ),
                        hint: context.l10n.noDate,
                        readOnly: true,
                        onTapped: () => cubit.onDatePickerTapped(
                          isValid: cubit.selectedStartDate != null,
                          isStart: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar:
          BottomActions(onSave: () => cubit.saveEmployeeDataToDb(isEdit)),
    );
  }
}

class BottomActions extends StatelessWidget {
  const BottomActions({
    required this.onSave,
    this.onCancel,
    super.key,
  });
  final void Function() onSave;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Row(
          children: [
            const Spacer(),
            CancelButton(
              onPressed: onCancel ??
                  () => context
                      .pop, // Calls onCancel when Defined, else pops by default
            ),
            SizedBox(
              width: context.screenWidth * 0.03738317757,
            ),
            SaveButton(
              onPressed: onSave, //Calls OnPressed when save is tapped
            ),
            SizedBox(
              width: context.screenWidth * 0.03738317757,
            ),
          ],
        ),
      ],
    );
  }
}

///TODO: 
/// Add SQFLite
/// Add Cubit Logic to Save Employee

