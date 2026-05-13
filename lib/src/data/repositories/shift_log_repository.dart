import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/shift_log.dart';

class ShiftLogRepository {
  final Database _db;
  ShiftLogRepository(this._db);

  void create(ShiftLog log) {
    _db.execute(
      'INSERT INTO shift_logs (shift_date, employee_id) VALUES (?, ?)',
      [log.shiftDate, log.employeeId],
    );
  }

  List<ShiftLog> getAll() {
    final results = _db.select('SELECT * FROM shift_logs');
    return results.map((row) => ShiftLog.fromMap(row)).toList();
  }
}