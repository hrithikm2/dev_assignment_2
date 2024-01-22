import 'package:bloc/bloc.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial());
}
