// ignore_for_file: avoid_positional_boolean_parameters

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

part 'add_employee_state.dart';

enum DateOption { noDate, today, nextMonday, nextTuesday, afterOneWeek }

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeInitial()) {
    nameController = TextEditingController();
    roleController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
  }
  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  DateTime? selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateOption value = DateOption.today;

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

  void onDaySelected(DateTime selected, DateTime focused) {
    if (!isSameDay(selectedDay, selected)) {
      selectedDay = selected;
      focusedDay = focused;
    }
    _formatDate();
    emit(DateChanged(date: selectedDay));
  }

  // ignore: inference_failure_on_function_return_type, always_declare_return_types
  void onChoiceChipTapped(bool selected, DateOption selectedValue) {
    value = selectedValue;
    switch (selectedValue) {
      case DateOption.today:
        selectedDay = DateTime.now();
      case DateOption.nextMonday:
        selectedDay = calculateNextDay(dayCount: 1);
      case DateOption.nextTuesday:
        selectedDay = calculateNextDay(dayCount: 2);
      case DateOption.afterOneWeek:
        selectedDay = calculateNextDay(dayCount: 7);
      case DateOption.noDate:
        selectedDay = null;
    }
    emit(DateChanged(date: selectedDay));
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

  void _formatDate() {
    if (selectedDay != null) {
      formattedDate = DateFormat('dd MMM yyyy').format(selectedDay!);
    }
  }

  void saveDate(TextEditingController controller) {
    _formatDate();
    controller.text = formattedDate;
    emit(const DateSelected());
  }
}
