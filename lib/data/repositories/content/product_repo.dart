import 'package:gmn/data/models/content/store/product.dart';
import 'package:gmn/data/helpers/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class ProductRepo extends Repo<Product> {
  static const String mName = "store";

  ProductRepo.fromMap(Map map) {
    super.fromMap(map);
  }

  @override
  void update(Repo tempRepo) {
    super.update(tempRepo);
  }

  static Future<ProductRepo> getAllProducts(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce = await DioHelper.io.get(
      token,
      mName,
      '',
      queryParameter,
    );
    Map responceData = responce["data"];

    List<Product> equipments = await loadProducts(responceData);

    Map equipmentRepoMap = {
      'totalCount': responceData['totalCount'],
      'page': responceData['page'],
      'limit': responceData['limit'],
      'next': responceData['next'],
      'items': equipments,
    };

    ProductRepo equipmentRepo = ProductRepo.fromMap(equipmentRepoMap);

    return equipmentRepo;
  }

  static Future<List<Product>> loadProducts(Map data) async {
    List<Product> equipments = [];
    List equipmentsMapList = data["results"];
    equipments = equipmentsMapList.map((e) => Product.fromMap(e)).toList();
    return equipments;
  }
}
