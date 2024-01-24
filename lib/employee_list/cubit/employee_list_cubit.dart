import 'package:bloc/bloc.dart';
import 'package:dev_assignment_2/database/database.dart';
import 'package:dev_assignment_2/models/employee_model.dart';
import 'package:equatable/equatable.dart';

part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial()) {
    getData();
  }

  List<EmployeeModel> currentEmployees = [];
  List<EmployeeModel> allEmployees = [];
  List<EmployeeModel> previousEmployees = [];
  (EmployeeModel, int)? deletedEmp;
  bool shouldDeleteEmployee = true;

  Future<void> getData() async {
    allEmployees = await SqfliteDatabase.getDataFromDatabase();
    _separateCurrentAndPrevious();
    emit(EmployeeListSuccess());
  }

  void _separateCurrentAndPrevious() {
    currentEmployees =
        allEmployees.where((element) => element.isPrevious == 0).toList();
    previousEmployees =
        allEmployees.where((element) => element.isPrevious == 1).toList();
  }

  Future<void> removeItemFromDbAndList(String empId, int index) async {
    deletedEmp =
        (allEmployees.where((element) => element.id == empId).first, index);
    allEmployees.removeWhere((element) => element.id == empId);
    _separateCurrentAndPrevious();
    emit(EmployeeListRemovedItem(index: index, empId: empId));
  }

  Future<void> removeItemFromDb(String empId) async {
    if (shouldDeleteEmployee) {
      await SqfliteDatabase.deleteDataFromDatabase(empId);
    } else {
      shouldDeleteEmployee = true;
    }
  }

  void restoreEmployee() {
    if (deletedEmp != null) {
      shouldDeleteEmployee = false;
      allEmployees.insert(deletedEmp!.$2, deletedEmp!.$1);
      _separateCurrentAndPrevious();
      emit(EmployeeListItemRestored());
    }
  }
}
