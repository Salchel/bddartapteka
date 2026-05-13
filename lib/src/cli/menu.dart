import 'dart:io';
import '../data/repositories/product_repository.dart';
import '../data/repositories/supplier_repository.dart';
import '../data/repositories/employee_repository.dart';
import '../data/repositories/contract_repository.dart';
import '../data/repositories/shift_log_repository.dart'; // ДОБАВЛЕНО: репозиторий смен
import '../domain/models/product.dart';
import '../domain/models/supply_contract.dart';
import '../domain/models/shift_log.dart'; // ДОБАВЛЕНО: модель смены
import '../domain/models/employee.dart';
import '../domain/models/supplier.dart';
import 'input_helper.dart';

class Menu {
  final ProductRepository productRepo;
  final SupplierRepository supplierRepo;
  final EmployeeRepository employeeRepo;
  final ContractRepository contractRepo;
  final ShiftLogRepository shiftLogRepo; // ИЗМЕНЕНО: добавлено поле для журнала смен

  // ИЗМЕНЕНО: обновлен конструктор (принимает 5 репозиториев)
  Menu(this.productRepo, this.supplierRepo, this.employeeRepo, this.contractRepo, this.shiftLogRepo);

  void run() {
    bool isRunning = true;
    while (isRunning) {
      print('\n=== АПТЕЧНАЯ СИСТЕМА ===');
      print('1. Товары (Просмотр/Добавление)');
      print('2. Поставщики (Просмотр/Добавление)');
      print('3. Договоры поставки (Связь с поставщиком)');
      print('4. Персонал (Просмотр/Добавление)'); // ДОБАВЛЕНО: пункт меню
      print('5. Журнал смен (Связь с персоналом)'); // ДОБАВЛЕНО: пункт меню
      print('6. ПОКАЗАТЬ ВСЁ ИЗ БД');
      print('0. Выход');
      stdout.write('Выберите действие: ');

      final choice = stdin.readLineSync();

      switch (choice) {
        case '1': _manageProducts(); break;
        case '2': _manageSuppliers(); break;
        case '3': _addContract(); break;
        case '4': _manageEmployees(); break; // ИЗМЕНЕНО: вызов метода
        case '5': _manageShiftLogs(); break; // ДОБАВЛЕНО: вызов метода
        case '6': _showAllTables(); break;
        case '0': isRunning = false; break;
        default: print('Неверный выбор.');
      }
    }
  }

  void _addContract() {
    final suppliers = supplierRepo.getAll();
    if (suppliers.isEmpty) {
      print('Ошибка: Сначала добавьте хотя бы одного поставщика!');
      return;
    }

    print('\nДоступные поставщики:');
    for (var s in suppliers) {
      print('[ID: ${s.id}] ${s.name}');
    }

    final number = InputHelper.askString('Введите номер договора');
    final date = InputHelper.askString('Введите дату (ГГГГ-ММ-ДД)');
    final sId = InputHelper.askInt('Введите ID поставщика из списка выше');

    contractRepo.create(SupplyContract(
      contractNumber: number,
      date: date,
      supplierId: sId,
    ));
    print('Договор успешно создан и привязан к поставщику!');
  }

  // ДОБАВЛЕНО: логика для управления сменами (демонстрация связи)
  void _manageShiftLogs() {
    print('\n1. Список смен\n2. Назначить сотрудника на смену\n0. Назад');
    final choice = stdin.readLineSync();

    if (choice == '1') {
      final logs = shiftLogRepo.getAll();
      if (logs.isEmpty) print('Журнал пуст.');
      for (var l in logs) print('Дата: ${l.shiftDate} | ID Сотрудника: ${l.employeeId}');
    } else if (choice == '2') {
      final emps = employeeRepo.getAll();
      if (emps.isEmpty) {
        print('Ошибка: Сначала добавьте сотрудников!');
        return;
      }
      for (var e in emps) print('[ID: ${e.id}] ${e.fullName}');
      
      final date = InputHelper.askString('Дата смены (ГГГГ-ММ-ДД)');
      final eId = InputHelper.askInt('Введите ID сотрудника');
      
      shiftLogRepo.create(ShiftLog(shiftDate: date, employeeId: eId));
      print('Смена успешно зарегистрирована!');
    }
  }

  void _showAllTables() {
    print('\n=== ПОЛНЫЙ ОТЧЕТ ИЗ БАЗЫ ДАННЫХ ===');
    _showAllProducts();
    
    final suppliers = supplierRepo.getAll();
    print('\nПОСТАВЩИКИ: ${suppliers.length}');
    for (var s in suppliers) print('- ${s.name} (${s.contactInfo})');

    final contracts = contractRepo.getAll();
    print('\nДОГОВОРЫ: ${contracts.length}');
    for (var c in contracts) print('- №${c.contractNumber} от ${c.date} (ID поставщика: ${c.supplierId})');

    // ДОБАВЛЕНО: вывод сотрудников и смен в общий список
    final emps = employeeRepo.getAll();
    print('\nСОТРУДНИКИ: ${emps.length}');
    for (var e in emps) print('- ${e.fullName} (${e.position})');

    final logs = shiftLogRepo.getAll();
    print('\nСМЕНЫ В ЖУРНАЛЕ: ${logs.length}');
    for (var l in logs) print('- ${l.shiftDate} (Сотрудник ID: ${l.employeeId})');
  }

  void _showAllProducts() {
    final products = productRepo.getAll();
    print('\nТОВАРЫ:');
    if (products.isEmpty) print('Пусто');
    for (var p in products) {
      print('[ID: ${p.id}] ${p.name} | ${p.price} руб. | Склад: ${p.stockQuantity}');
    }
  }

  void _manageProducts() {
    print('\n1. Показать товары\n2. Добавить товар\n0. Назад');
    final choice = stdin.readLineSync();
    if (choice == '1') _showAllProducts();
    if (choice == '2') {
      final name = InputHelper.askString('Название');
      final price = InputHelper.askDouble('Цена');
      final qty = InputHelper.askInt('Кол-во');
      productRepo.create(Product(name: name, price: price, stockQuantity: qty));
      print('Товар добавлен!');
    }
  }

  void _manageSuppliers() {
    print('\n--- УПРАВЛЕНИЕ ПОСТАВЩИКАМИ ---');
    print('1. Список поставщиков\n2. Добавить поставщика\n0. Назад');
    final choice = stdin.readLineSync();
    
    if (choice == '1') {
      final suppliers = supplierRepo.getAll();
      if (suppliers.isEmpty) print('Список пуст.');
      for (var s in suppliers) print('[ID: ${s.id}] ${s.name} | ${s.contactInfo}');
    } else if (choice == '2') {
      final name = InputHelper.askString('Название компании');
      final info = InputHelper.askString('Контактные данные');
      supplierRepo.create(Supplier(name: name, contactInfo: info));
      print('Поставщик добавлен!');
    }
  }

  void _manageEmployees() {
    print('\n--- УПРАВЛЕНИЕ ПЕРСОНАЛОМ ---');
    print('1. Список сотрудников\n2. Добавить сотрудника\n0. Назад');
    final choice = stdin.readLineSync();

    if (choice == '1') {
      final emps = employeeRepo.getAll();
      if (emps.isEmpty) print('Сотрудников нет.');
      for (var e in emps) print('[ID: ${e.id}] ${e.fullName} — ${e.position}');
    } else if (choice == '2') {
      final name = InputHelper.askString('ФИО сотрудника');
      final pos = InputHelper.askString('Должность');
      employeeRepo.create(Employee(fullName: name, position: pos));
      print('Сотрудник принят на работу!');
    }
  }
}



  // ИЗМЕНЕНО: метод