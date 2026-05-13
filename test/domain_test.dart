import 'package:test/test.dart';
import 'package:bddartapteka/src/domain/models/product.dart';

void main() {
  test('Конвертация модели Product в Map и обратно', () {
    final product = Product(id: 1, name: "Омепразол", price: 250.0, stockQuantity: 10);

    //tomap
    final map = product.toMap();
    expect(map['name'], "Омепразол");
    expect(map['price'], 250.0);

    //frommap
    final fromMapProduct = Product.fromMap(map);
    expect(fromMapProduct.name, product.name);
    expect(fromMapProduct.price, product.price);
  });
}