import 'package:bloc/bloc.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_state.dart';
import 'package:flutter/material.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial()) {
    nameController = TextEditingController();
    roleController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
  }

  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  List<String> roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
  ];

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    startDateController.dispose();
    endDateController.dispose();

    return super.close();
  }
}
