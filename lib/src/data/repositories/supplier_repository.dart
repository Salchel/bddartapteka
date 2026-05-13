import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/supplier.dart';

class SupplierRepository {
  final Database _db;
  SupplierRepository(this._db);

  void create(Supplier supplier) {
    _db.execute(
      'INSERT INTO suppliers (name, contact_info) VALUES (?, ?)',
      [supplier.name, supplier.contactInfo],
    );
  }

  List<Supplier> getAll() {
    final results = _db.select('SELECT * FROM suppliers');
    return results.map((row) => Supplier.fromMap(row)).toList();
  }

  void update(Supplier supplier) {
    _db.execute(
      'UPDATE suppliers SET name = ?, contact_info = ? WHERE id = ?',
      [supplier.name, supplier.contactInfo, supplier.id],
    );
  }

  void delete(int id) {
    _db.execute('DELETE FROM suppliers WHERE id = ?', [id]);
  }
} 