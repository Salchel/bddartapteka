class ShiftLog {
  final int? id;
  final String shiftDate;
  final int employeeId;

  ShiftLog({
    this.id,
    required this.shiftDate,
    required this.employeeId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shift_date': shiftDate,
      'employee_id': employeeId,
    };
  }

  factory ShiftLog.fromMap(Map<String, dynamic> map) {
    return ShiftLog(
      id: map['id'] as int?,
      shiftDate: map['shift_date'] as String,
      employeeId: map['employee_id'] as int,
    );
  }
}