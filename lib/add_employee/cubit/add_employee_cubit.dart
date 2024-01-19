import 'package:bloc/bloc.dart';
import 'package:dev_assignment_2/add_employee/cubit/add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeInitial> {
  AddEmployeeCubit() : super(AddEmployeeInitial());
}
