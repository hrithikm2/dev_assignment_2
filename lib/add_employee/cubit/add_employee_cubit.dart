// ignore_for_file: avoid_positional_boolean_parameters

import 'package:bloc/bloc.dart';
import 'package:dev_assignment_2/database/database.dart';
import 'package:dev_assignment_2/models/employee_model.dart';
import 'package:dev_assignment_2/utils/app_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeInitial()) {
    nameController = TextEditingController();
    roleController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    focusedDay = DateTime.now();
  }

  late EmployeeModel employee;
  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  DateTime? selectedStartDate;
  late DateTime? selectedEndDate; //End Date will be after selectedStartDate
  late DateTime focusedDay;
  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateOption value = DateOption.today;

  List<String> roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
  ];

  bool selectedDatePredicate(DateTime day, DateTime? selectionDate) {
    emit(DateChanged(date: selectionDate));
    return isSameDay(selectionDate, day);
  }

  void onStartDateSelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedStartDate, selected)) {
      selectedStartDate = selected;
      print('focused: $focused,, selectedStart : $selectedStartDate');
      focusedDay = focused.add(const Duration(days: 1));
    }
    _formatDate(selectedStartDate);
    selectedEndDate = selectedStartDate;
    emit(DateChanged(date: selectedStartDate));
  }

  void onDatePickerTapped({required bool isValid, required bool isStart}) {
    emit(RequestedDatePicker(isValid: isValid, isStart: isStart));
  }

  void onEndDateSelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedEndDate, selected)) {
      selectedEndDate = selected;
      focusedDay = focused;
    }
    _formatDate(selectedEndDate);

    emit(DateChanged(date: selectedEndDate));
  }

  // ignore: inference_failure_on_function_return_type
  void onChoiceChipTapped(
    bool selected,
    DateOption selectedValue,
    bool isStart,
  ) {
    value = selectedValue;
    DateTime? selectedDate;
    switch (selectedValue) {
      case DateOption.today:
        selectedDate = DateTime.now();
        focusedDay = selectedDate.add(const Duration(days: 1));

      case DateOption.nextMonday:
        selectedDate = calculateNextDay(dayCount: 1);
        focusedDay = selectedDate.add(const Duration(days: 1));

      case DateOption.nextTuesday:
        selectedDate = calculateNextDay(dayCount: 2);
        focusedDay = selectedDate.add(const Duration(days: 1));

      case DateOption.afterOneWeek:
        selectedDate = calculateNextDay(dayCount: 7);
        focusedDay = selectedDate.add(const Duration(days: 1));

      case DateOption.noDate:
        selectedDate = null;
    }
    if (isStart) {
      selectedStartDate = selectedDate;
    } else {
      selectedEndDate = selectedDate;
    }
    emit(DateChanged(date: selectedDate));
  }

  ///[dayCount] variable decides on what day of week to jump to.
  /// 1 = Monday, 2=Tuesday and so on.. till 7
  DateTime calculateNextDay({required int dayCount}) {
    final currentDate = DateTime.now();
    var difference = dayCount - currentDate.weekday;
    if (difference <= 0) {
      difference += 7;
    }
    final nextMonday = currentDate.add(Duration(days: difference));
    return nextMonday;
  }

  void _formatDate(DateTime? selectionDate) {
    if (selectionDate != null) {
      formattedDate = DateFormat('dd MMM yyyy').format(selectionDate);
    } else {
      formattedDate = 'N.A.';
    }
  }

  void saveDate(TextEditingController controller, DateTime? selectionDate) {
    _formatDate(selectionDate);
    controller.text = formattedDate;
    emit(const DateSelected());
  }

  Future<void> saveEmployeeDataToDb(bool isEdit) async {
    if (nameController.text.isNotEmpty &&
        roleController.text.isNotEmpty &&
        endDateController.text.isNotEmpty &&
        startDateController.text.isNotEmpty) {
      final data = {
        'id': const Uuid().v4(),
        'name': nameController.text,
        'role': roleController.text,
        'startDate': startDateController.text,
        'endDate': endDateController.text,
        'isPrevious': selectedEndDate == null ? 0 : 1,
      };
      employee = EmployeeModel.fromJson(data);
      if (isEdit) {
        await SqfliteDatabase.updateDataInDatabase(
          employee,
        ).then((value) => emit(const AddEmployeeSuccess()));
      } else {
        await SqfliteDatabase.insertData(employee)
            .then((value) => emit(const AddEmployeeSuccess()));
      }
    } else {
      emit(const AddEmployeeInvalid());
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    startDateController.dispose();
    endDateController.dispose();

    return super.close();
  }
}
