import 'package:flutter/widgets.dart';
import 'package:gmn/data/models/store/product.dart';
import 'package:gmn/data/repositories/store_repo.dart';

class StoreProvider extends ChangeNotifier {
  List<Product>? products;

  Future<void> getAllProducts() async {
    products = await StoreRepo().getAllProducts();
    notifyListeners();
  }
}
