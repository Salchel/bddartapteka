import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_library_windows/sqlite3_library_windows.dart';

class DatabaseHelper {
  static const String _dbPath = 'pharmacy.db';
  late final Database _db;

  //боже, уничтожь это говно нерабочее
  DatabaseHelper() {
    try {
      sqlite3.open(_dbPath);
      _db = sqlite3.open(_dbPath);
      _db.execute('PRAGMA foreign_keys = ON;');
      _createTables();
    } catch (e) {
      print('Критическая ошибка при открытии БД: $e');
      rethrow;
    }
  } 
  Database get db => _db;

  void _createTables() {
    _db.execute('''
      CREATE TABLE IF NOT EXISTS suppliers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contact_info TEXT NOT NULL
      );
''');

_db.execute('''
      CREATE TABLE IF NOT EXISTS employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        position TEXT NOT NULL
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        stock_quantity INTEGER NOT NULL
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS supply_contracts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        contract_number TEXT NOT NULL,
        date TEXT NOT NULL,
        supplier_id INTEGER,
        FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
      );
    ''');

    _db.execute('''
      CREATE TABLE IF NOT EXISTS shift_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        shift_date TEXT NOT NULL,
        employee_id INTEGER,
        FOREIGN KEY (employee_id) REFERENCES employees (id)
      );
    ''');
  }

  void close() => _db.dispose();
}