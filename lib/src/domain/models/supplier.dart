class Supplier {
  final int? id;
  final String name;
  final String contactInfo;

  Supplier({this.id, required this.name, required this.contactInfo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact_info': contactInfo,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      contactInfo: map['contact_info'],
    );
  }
}