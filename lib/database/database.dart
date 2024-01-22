import 'package:dev_assignment_2/models/employee_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  static late Database _db;

  static Future<void> initialiseDatabase() async {
    final applicationDirectory = await getApplicationDocumentsDirectory();

    final databasePath = '${applicationDirectory.path}employees.db';

    _db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        // ignore: lines_longer_than_80_chars
        await db.execute(
          'CREATE TABLE Employees (id INTEGER PRIMARY KEY, name TEXT, role TEXT, startTime TEXT,endTime TEXT)',
        );
      },
    );
  }

  static Future<List<EmployeeModel>> getDataFromDatabase() async {
    final result = await _db.query('Employees');

    final employeeModel = result.map(EmployeeModel.fromJson).toList();

    return employeeModel;
  }

  static Future<void> insertData(EmployeeModel model) async {
    final result = await _db.insert('Employees', model.toJson());

    print(result);
  }

  static Future<void> deleteDataFromDatabase(int time) async {
    final result =
        await _db.delete('Employees', where: 'time = ?', whereArgs: [time]);

    print(result);
  }

  static Future<void> updateDataInDatabase(
    EmployeeModel model,
  ) async {
    final result = await _db.update(
      'Employees',
      model.toJson(),
    );

    print(result);
  }
}
