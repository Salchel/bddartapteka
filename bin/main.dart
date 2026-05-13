import 'package:bddartapteka/src/data/database.dart';
import 'package:bddartapteka/src/data/repositories/product_repository.dart';
import 'package:bddartapteka/src/data/repositories/supplier_repository.dart';
import 'package:bddartapteka/src/data/repositories/employee_repository.dart';
import 'package:bddartapteka/src/data/repositories/contract_repository.dart';
import 'package:bddartapteka/src/data/repositories/shift_log_repository.dart';
import 'package:bddartapteka/src/cli/menu.dart';
import 'dart:io';

void main() {
  if (Platform.isWindows) {
    Process.runSync('cmd', ['/c', 'chcp 65001']);
  }
  
  final dbHelper = DatabaseHelper();
  
  final menu = Menu(
    ProductRepository(dbHelper.db),
    SupplierRepository(dbHelper.db),
    EmployeeRepository(dbHelper.db),
    ContractRepository(dbHelper.db),
    ShiftLogRepository(dbHelper.db),
  );

  menu.run();
  dbHelper.close();
}