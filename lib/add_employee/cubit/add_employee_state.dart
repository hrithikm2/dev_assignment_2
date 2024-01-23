// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_employee_cubit.dart';

sealed class AddEmployeeState extends Equatable {
  const AddEmployeeState();
  @override
  List<Object?> get props => [];
}

class AddEmployeeInitial extends AddEmployeeState {}

class DateChanged extends AddEmployeeState {
  const DateChanged({
    required this.date,
  });
  final DateTime? date;

  @override
  List<Object?> get props => [date];
}

class DateSelected extends AddEmployeeState {
  const DateSelected();
}

class AddEmployeeSuccess extends AddEmployeeState {
  const AddEmployeeSuccess();
}

class AddEmployeeInvalid extends AddEmployeeState {
  const AddEmployeeInvalid();
  @override
  List<Object?> get props => [];
}

class RequestedDatePicker extends AddEmployeeState {
  const RequestedDatePicker({required this.isValid, required this.isStart});
  final bool isValid;
  final bool isStart;
  @override
  List<Object> get props => [isValid, isStart];
}
