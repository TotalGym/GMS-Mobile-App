class Product {
  static String mName = "store";

  String? id;
  String? productName;
  String? description;
  String? image;
  int? inventoryCount;
  num? price;
  int? totalRevenue;

  Product.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    productName = map["productName"];
    description = map["description"];
    image = map["image"];
    inventoryCount = map["inventoryCount"];
    price = map["price"];
    totalRevenue = map["totalRevenue"];
  }
  @override
  String toString() =>
      "name: $productName, price: $price, revenue: $totalRevenue";
}
