import 'package:test/test.dart';
import 'package:bddartapteka/src/domain/validators/validators.dart';

void main() {
  group('Валидация текстовых полей:', () {
    test('пустая строка', () {
      expect(Validators.isNotEmpty("Аспирин"), isTrue);
      expect(Validators.isNotEmpty("   "), isFalse);
      expect(Validators.isNotEmpty(null), isFalse);
    });
  });

  group('Валидация числовых полей:', () {
    test('проверка на отрицательное число', () {
      expect(Validators.isGreaterThanZero(100), isTrue);
      expect(Validators.isGreaterThanZero(0), isFalse);
      expect(Validators.isGreaterThanZero(-5), isFalse);
    });
  });
}