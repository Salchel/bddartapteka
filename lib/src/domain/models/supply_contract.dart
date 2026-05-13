class SupplyContract {
  final int? id;
  final String contractNumber;
  final String date;
  final int supplierId;

  SupplyContract({
    this.id,
    required this.contractNumber,
    required this.date,
    required this.supplierId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contract_number': contractNumber,
      'date': date,
      'supplier_id': supplierId,
    };
  }

  factory SupplyContract.fromMap(Map<String, dynamic> map) {
    return SupplyContract(
      id: map['id'] as int?,
      contractNumber: map['contract_number'] as String,
      date: map['date'] as String,
      supplierId: map['supplier_id'] as int,
    );
  }
}