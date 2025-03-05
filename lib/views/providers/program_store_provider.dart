import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/data/models/content/program_store_interface.dart';
import 'package:gmn/data/models/content/store/product.dart';
import 'package:gmn/data/repositories/program_repo.dart';
import 'package:gmn/data/repositories/store_repo.dart';

class ProgramStoreProvider extends ChangeNotifier {
  List<Program>? programs;
  List<Product>? products;

  List<ProgramStore>? homeState;

  Future<void> getAllProducts(String token) async {
    products = await StoreRepo().getAllProducts(token);
    notifyListeners();
  }

  getAllPrograms(String token) async {
    programs = await ProgramRepo().getAllPrograms(token);
    notifyListeners();
  }

  getHomeState(String token) async {
    homeState = await ProgramStore.getHomeState(token);
    log("ProgramStoreProvider-> getHomeSate : $homeState");
    notifyListeners();
  }
}
