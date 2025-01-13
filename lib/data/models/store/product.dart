class Product {
  late String id;
  late String name;
  late String image;
  late int inventoryCount;

  Product.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    name = map["productName"];
    image = map["image"];
    inventoryCount = map["inventoryCount"];
  }
}
