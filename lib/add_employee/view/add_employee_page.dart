import 'package:dev_assignment_2/common/cancel_button.dart';
import 'package:dev_assignment_2/common/save_button.dart';
import 'package:dev_assignment_2/common/text_field.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_cubit.dart';
import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/app_assets.dart';
import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeListCubit(),
      child: const AddEmployeeView(),
    );
  }
}

class AddEmployeeView extends StatelessWidget {
  const AddEmployeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<EmployeeListCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addEmployeeAppBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(context.screenWidth * 0.03738317757),
        child: Column(
          children: [
            //Name
            DefaultTextField(
              controller: cubit.nameController,
              icon: const Icon(
                Icons.person_outline,
                color: AppColors.appMainColor,
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
                color: AppColors.appMainColor,
              ),
              controller: cubit.nameController,
              readOnly: true,
              onTapped: () {
                showModalBottomSheet<String>(
                  context: context,
                  backgroundColor: AppColors.appWhite,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  builder: (_) => BottomSheet(
                    cubit: cubit,
                  ),
                );
              },
            ),
            SizedBox(
              height: context.screenHeight * 0.02483801295,
            ),

            //Dates
            Row(
              children: [
                Expanded(
                  child: DefaultTextField(
                    controller: cubit.nameController,
                    icon: SvgPicture.asset(
                      AppAssets.calendarIcon,
                    ),
                    hint: context.l10n.noDateHint,
                    readOnly: true,
                    onTapped: () {},
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.east,
                    size: 20,
                    color: AppColors.appMainColor,
                  ),
                ),
                Expanded(
                  child: DefaultTextField(
                    controller: cubit.nameController,
                    icon: SvgPicture.asset(
                      AppAssets.calendarIcon,
                    ),
                    hint: context.l10n.noDateHint,
                    readOnly: true,
                    onTapped: () {
                      print('OPEN CUSTOM DATE PICKER HERE');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomActions(),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({required this.cubit, super.key});
  final EmployeeListCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      shrinkWrap: true,
      itemCount: cubit.roles.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => Center(child: Text(cubit.roles[index])),
    );
  }
}

class BottomActions extends StatelessWidget {
  const BottomActions({super.key});

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
              onPressed: () => context.pop,
            ),
            SizedBox(
              width: context.screenWidth * 0.03738317757,
            ),
            SaveButton(
              onPressed: () {},
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
/// Add Custom Date Picker
/// Add SQLite
/// Add Cubit Logic to Save Employee

