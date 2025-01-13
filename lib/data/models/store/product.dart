class Product {
  late String id;
  late String productName;
  late String image;
  late int inventoryCount;

  Product.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    productName = map["productName"];
    image = map["image"];
    inventoryCount = map["inventoryCount"];
  }
}
