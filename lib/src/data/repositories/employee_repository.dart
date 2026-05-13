import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/employee.dart';

class EmployeeRepository {
  final Database _db;

  EmployeeRepository(this._db);
 
  void create(Employee employee) {
    final stmt = _db.prepare(
      'INSERT INTO employees (full_name, position) VALUES (?, ?)'
    );
    stmt.execute([employee.fullName, employee.position]);
    stmt.close();
  }

  List<Employee> getAll() {
    final ResultSet results = _db.select('SELECT * FROM employees');
    return results.map((row) => Employee.fromMap(row)).toList();
  }

  Employee? getById(int id) {
    final ResultSet results = _db.select('SELECT * FROM employees WHERE id = ?', [id]);
    if (results.isEmpty) return null;
    return Employee.fromMap(results.first);
  }

  void update(Employee employee) {
    if (employee.id == null) return; //проверка на пустоту айди
    _db.execute(
      'UPDATE employees SET full_name = ?, position = ? WHERE id = ?',
      [employee.fullName, employee.position, employee.id],
    );
  }

  void delete(int id) {
    _db.execute('DELETE FROM employees WHERE id = ?', [id]);
  }
}