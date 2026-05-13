class Employee {
  final int? id;
  final String fullName;
  final String position;

  Employee({this.id, required this.fullName, required this.position});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'position': position,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int?,
      fullName: map['full_name'] as String,
      position: map['position'] as String,
    );
  }
}