import 'package:dev_assignment_2/common/cancel_button.dart';
import 'package:dev_assignment_2/common/drop_down_text_field.dart';
import 'package:dev_assignment_2/common/save_button.dart';
import 'package:dev_assignment_2/common/text_field.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_cubit.dart';
import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            DefaultTextField(
              controller: cubit.nameController,
              hint: context.l10n.employeeNameHint,
            ),
            SizedBox(
              height: context.screenHeight * 0.02483801295,
            ),
            DropDownTextField(
              items: const [
                DropdownMenuItem<String>(
                  value: 'Flutter Developer',
                  child: Text('Flutter Developer'),
                ),
              ],
              hint: context.l10n.selectRoleHint,
            ),
            SizedBox(
              height: context.screenHeight * 0.02483801295,
            ),
            DefaultTextField(
              controller: cubit.nameController,
              hint: context.l10n.employeeNameHint,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomActions(),
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
