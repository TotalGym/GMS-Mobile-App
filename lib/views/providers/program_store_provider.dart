import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/data/models/content/program_store_interface.dart';
import 'package:gmn/data/models/content/store/product.dart';
import 'package:gmn/data/repositories/content/program_repo.dart';
import 'package:gmn/data/repositories/content/product_repo.dart';

class ProgramStoreProvider extends ChangeNotifier {
  ProductRepo? products;
  int productsPage = 1;

  ProgramRepo? programs;
  int programsPage = 1;

  List<Product>? homeProducts;
  List<Program>? homePrograms;

  Future<void> getAllProducts(String token) async {
    if (products == null) {
      products =
          await ProductRepo.getAllProducts(token, {"page": productsPage});
    } else {
      ProductRepo tempProducts =
          await ProductRepo.getAllProducts(token, {"page": productsPage});
      products!.update(tempProducts);
    }
    notifyListeners();
  }

  getAllPrograms(String token) async {
    if (programs == null) {
      programs =
          await ProgramRepo.getAllPrograms(token, {"page": programsPage});
    } else {
      ProgramRepo tempPrograms =
          await ProgramRepo.getAllPrograms(token, {"page": programsPage});
      programs!.update(tempPrograms);
    }
    notifyListeners();
  }

  getHomeState(String token) async {
    Map<String, dynamic> homeState = await ProgramStore.getHomeState(token);
    homeProducts = homeState["products"];
    homePrograms = homeState["programs"];
    log("ProgramStoreProvider-> getHomeSate : $homeState");
    notifyListeners();
  }

  Future<void> getProductsNextPage(String token) async {
    if (products!.next == null) {
      return;
    }
    productsPage++;
    await getAllProducts(token);
  }

  void resetProducts() {
    products = null;
    productsPage = 1;
    notifyListeners();
  }

  Future<void> getProgramsNextPage(String token) async {
    if (programs!.next == null) {
      return;
    }
    programsPage++;
    await getAllPrograms(token);
    return;
  }

  void resetPrograms() {
    programs = null;
    programsPage = 1;
    notifyListeners();
  }

  void reset() {
    resetProducts();
    resetPrograms();
  }
}
