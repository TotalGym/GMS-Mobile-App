import 'package:gmn/data/models/content/equipment/equipment.dart';
import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class EquipmentRepo extends Repo<Equipment> {
  static const String mName = "equipment";

  EquipmentRepo.fromMap(Map map) {
    totalCount = map['totalCount'];
    page = map['page'];
    limit = map['limit'];
    next =
        map['next'] != null ? Map<String, dynamic>.from(map['next']) : {"": ""};
    items = map["items"];
  }

  static Future<EquipmentRepo> getAllEquipments(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce = await DioHelper.io.get(
      token,
      mName,
      '',
      queryParameter,
    );
    Map responceData = responce["data"];

    List<Equipment> equipments = await loadEquipments(responceData);

    Map equipmentRepoMap = {
      'totalCount': responceData['totalCount'],
      'page': responceData['page'],
      'limit': responceData['limit'],
      'next': responceData['next'],
      'items': equipments,
    };

    EquipmentRepo equipmentRepo = EquipmentRepo.fromMap(equipmentRepoMap);

    return equipmentRepo;
  }

  static Future<List<Equipment>> loadEquipments(Map data) async {
    List<Equipment> equipments = [];
    List equipmentsMapList = data["results"];
    equipments = equipmentsMapList.map((e) => Equipment.fromMap(e)).toList();
    return equipments;
  }
}
