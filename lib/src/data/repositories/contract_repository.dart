import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/supply_contract.dart';

class ContractRepository {
  final Database _db;
  ContractRepository(this._db);

  void create(SupplyContract contract) {
    _db.execute(
      'INSERT INTO supply_contracts (contract_number, date, supplier_id) VALUES (?, ?, ?)',
      [contract.contractNumber, contract.date, contract.supplierId],
    );
  }

  List<SupplyContract> getAll() {
    final results = _db.select('''
      SELECT sc.*, s.name as supplier_name 
      FROM supply_contracts sc
      JOIN suppliers s ON sc.supplier_id = s.id
    ''');
    return results.map((row) => SupplyContract.fromMap(row)).toList();
  }
}