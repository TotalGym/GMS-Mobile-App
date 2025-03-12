import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/data/models/content/store/product.dart';
import 'package:gmn/data/network/dio_helper.dart';

abstract class ProgramStore {
  static const mName = "home";

  static Future<Map<String, dynamic>> getHomeState(String token) async {
    Map response = await DioHelper.io.get(token, mName, '', {});
    Map data = response["data"];
    List programsMapList = data["programs"];
    List productsMapList = data["products"];

    List<Program> programs = programsMapList.map((e) {
      return Program.fromMap(e);
    }).toList();

    List<Product> products = productsMapList.map((e) {
      return Product.fromMap(e);
    }).toList();

    Map<String, dynamic> homeState = {
      "products": products,
      "programs": programs,
    };

    return homeState;
  }
}
