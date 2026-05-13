import 'package:sqlite3/sqlite3.dart';
import '../../domain/models/product.dart';

class ProductRepository {
  final Database _db;

  // нужно, чтобы передать открытую бд в констрктор 
  ProductRepository(this._db);

  //добавление товара (create)
  void create(Product product) {
    final stmt = _db.prepare(
      'INSERT INTO products (name, price, stock_quantity) VALUES (?, ?, ?)'
    );
    stmt.execute([product.name, product.price, product.stockQuantity]);
    stmt.dispose();
  }

  //показать все содержимое бд (read)
  List<Product> getAll() {
    final ResultSet results = _db.select('SELECT * FROM products');
    return results.map((row) => Product.fromMap(row)).toList();
  }

  //изменить инфу (update)
  void update(Product product) {
    if (product.id == null) return;
    _db.execute(
      'UPDATE products SET name = ?, price = ?, stock_quantity = ? WHERE id = ?',
      [product.name, product.price, product.stockQuantity, product.id],
    );
  }

  //удаление данных из бд (delete)
  void delete(int id) {
    _db.execute('DELETE FROM products WHERE id = ?', [id]);
  }
}