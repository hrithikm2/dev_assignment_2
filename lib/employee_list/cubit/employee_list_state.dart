part of 'employee_list_cubit.dart';

abstract class EmployeeListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoading extends EmployeeListState {}

class EmployeeListSuccess extends EmployeeListState {}

class EmployeeListRemovedItem extends EmployeeListState {
  EmployeeListRemovedItem({required this.index, required this.empId});

  final int index;
  final String empId;
  @override
  List<Object> get props => [empId];
}

class EmployeeListItemRestored extends EmployeeListState {}
