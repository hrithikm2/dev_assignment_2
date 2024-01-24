import 'package:dev_assignment_2/add_employee/add_employee.dart';
import 'package:dev_assignment_2/common/employee_list_tile.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_cubit.dart';
import 'package:dev_assignment_2/l10n/l10n.dart';
import 'package:dev_assignment_2/utils/app_assets.dart';
import 'package:dev_assignment_2/utils/app_colors.dart';
import 'package:dev_assignment_2/utils/common_functions.dart';
import 'package:dev_assignment_2/utils/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmployeeListView();
  }
}

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.altWhite,
      appBar: AppBar(title: Text(l10n.employeeListAppBarTitle)),
      body: BlocConsumer<EmployeeListCubit, EmployeeListState>(
        listener: (context, state) {
          final cubit = context.read<EmployeeListCubit>();
          if (state is EmployeeListRemovedItem) {
            CommonFunctions.showSnackbar(
              context,
              'Employee data has been deleted',
              buttonLabel: 'Undo',
              onTap: cubit.restoreEmployee,
              onClosed: () => cubit.removeItemFromDb(state.empId),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<EmployeeListCubit>();
          if (cubit.currentEmployees.isNotEmpty ||
              cubit.previousEmployees.isNotEmpty) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (cubit.currentEmployees.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Current Employees',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final employee = cubit.currentEmployees[index];
                        return EmployeeListTile(
                          employeeName: employee.name ?? '',
                          employeeRole: employee.role ?? '',
                          employeeDuration: 'From ${employee.startDate}',
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: cubit.currentEmployees.length,
                    ),
                  ],
                  if (cubit.previousEmployees.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: AppColors.altWhite,
                      child: const Text(
                        'Previous Employees',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.mainColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final employee = cubit.previousEmployees[index];

                        return EmployeeListTile(
                          employeeName: employee.name ?? '',
                          employeeRole: employee.role ?? '',
                          employeeDuration:
                              '${employee.startDate}-${employee.startDate}',
                          onTap: () => context.push(
                            MaterialPageRoute(
                              builder: (context) => const AddEmployeePage(
                                isEdit: true,
                              ),
                            ),
                          ),
                          onDiscard: (p0) => cubit.removeItemFromDbAndList(
                            employee.id!,
                            index,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: cubit.previousEmployees.length,
                    ),
                  ],
                  if (cubit.currentEmployees.isNotEmpty ||
                      cubit.previousEmployees.isNotEmpty) ...[
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        'Swipe left to delete',
                        style: TextStyle(
                          color: AppColors.hintTextColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          } else {
            return const Center(child: NoEmployeeFound());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          MaterialPageRoute(
            builder: (context) => const AddEmployeePage(),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.white,
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
