import 'dart:io';
import '../domain/validators/validators.dart';

class InputHelper {
  //обработка пустой строки
  static String askString(String message) {
    while (true) {
      stdout.write('$message: ');
      final input = stdin.readLineSync()?.trim();
      if (Validators.isNotEmpty(input)) {
        return input!;
      }
      print('Ошибка: поле не может быть пустым.');
    }
  }

  //обработка чисе
  static double askDouble(String message) {
    while (true) {
      stdout.write('$message: ');
      final input = stdin.readLineSync();
      final value = double.tryParse(input ?? '');
      if (Validators.isGreaterThanZero(value)) {
        return value!;
      }
      print('Ошибка: введите число больше 0.');
    }
  }

  //обработка целочисленного айди
  static int askInt(String message) {
    while (true) {
      stdout.write('$message: ');
      final input = stdin.readLineSync();
      final value = int.tryParse(input ?? '');
      if (value != null && value > 0) {
        return value;
      }
      print('Ошибка: введите корректный ID.');
    }
  }
}