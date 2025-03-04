import 'dart:developer';

import 'package:gmn/data/models/store/product.dart';
import 'package:gmn/data/network/dio_helper.dart';

class StoreRepo {
  Future<List<Product>> getAllProducts() async {
    //ignore: avoid_log
    log("inside StoreRep->getProducts");

    Map<String, dynamic> data = await DioHelper.io.get(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWIzMjlmZmExYmUxNTY3MDgyMDI3ZiIsInJvbGUiOiJUcmFpbmVlIiwiaWF0IjoxNzQwODIyNTgyLCJleHAiOjE3NDE0MjczODJ9.DJ9jNiT4rJGsU2urlOCP5OPTgJImM0KBkFdWF0HGVC4",
        Product.mName,
        "nothing",
        '');

    //ignore: avoid_log
    log(data['data']['results'].toString());

    //ignore: avoid_log
    log("inside TraineeRepo->getTrainee after");

    List productMapList = data['data']['results'];

    List<Product> products = productMapList.map((e) {
      //ignore: avoid_log
      log("store_repo-> return value is: $e");

      //ignore: avoid_log
      log("store_repo-> return value as product is: ${Product.fromMap(e)}");
      return Product.fromMap(e);
    }).toList();

    //ignore: avoid_log
    log("products are: $products");

    return products;
  }
}
