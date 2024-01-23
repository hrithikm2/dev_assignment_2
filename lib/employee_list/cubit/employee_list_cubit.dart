import 'package:bloc/bloc.dart';
import 'package:dev_assignment_2/database/database.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_state.dart';
import 'package:dev_assignment_2/models/employee_model.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial()) {
    getData();
  }

  Future<void> getData() async {
    employees = await SqfliteDatabase.getDataFromDatabase();
    print(employees.first.name);
  }

  List<EmployeeModel> employees = [];
}
