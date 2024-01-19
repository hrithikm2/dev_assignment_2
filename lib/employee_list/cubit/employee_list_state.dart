import 'package:equatable/equatable.dart';

abstract class EmployeeListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeListInitial extends EmployeeListState {}
