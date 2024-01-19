import 'package:dev_assignment_2/add_employee/add_employee.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_cubit.dart';
import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/app_assets.dart';
import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeListCubit(),
      child: const EmployeeListView(),
    );
  }
}

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.employeeListAppBarTitle)),
      body: const Center(child: NoEmployeeFound()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          MaterialPageRoute(
            builder: (context) => const AddEmployeePage(),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.appWhite,
        ),
      ),
    );
  }
}

class NoEmployeeFound extends StatelessWidget {
  const NoEmployeeFound({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppAssets.noEmployeeFoundSvg);
  }
}
