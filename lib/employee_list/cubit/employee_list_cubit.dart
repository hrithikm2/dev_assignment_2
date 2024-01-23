import 'package:bloc/bloc.dart';
import 'package:dev_assignment_2/database/database.dart';
import 'package:dev_assignment_2/employee_list/cubit/employee_list_state.dart';
import 'package:dev_assignment_2/models/employee_model.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial()) {
    getData();
  }

  Future<void> getData() async {
    final allEmployees = await SqfliteDatabase.getDataFromDatabase();
    allEmployees.where((element) => element.isPrevious == 1);
  }

  List<EmployeeModel> currentEmployees = [];
  List<EmployeeModel> previousEmployees = [];
}
