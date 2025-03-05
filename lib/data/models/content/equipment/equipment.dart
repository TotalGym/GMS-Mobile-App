class Equipment {
  static const mName = "equipment";

  String? id;
  String? name;
  String? type;
  int? quantity;
  String? image;
  String? status;
  DateTime? createdAt;

  Equipment.fromMap(Map map) {
    id = map["_id"];
    name = map["name"];
    type = map["type"];
    quantity = map["quantity"];
    image = map["image"];
    status = map["status"];
    createdAt = DateTime.parse(map["createdAt"] ?? "2025-2-11T14:20:06.114Z");
  }

  @override
  String toString() {
    return "Equipment id: $id\nName: $name\nQuantity: $quantity";
  }
}
