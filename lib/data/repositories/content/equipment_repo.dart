import 'package:gmn/data/models/content/equipment/equipment.dart';
import 'package:gmn/data/network/dio_helper.dart';

class EquipmentRepo {
  static const String mName = "equipment";

  Future<List<Equipment>> getAllEquipments(String token) async {
    Map responce = await DioHelper.io.get(token, mName, "", "");
    List equipmentsMapList = responce["data"]["results"];

    List<Equipment> equipments = [];
    equipments = equipmentsMapList.map((e) => Equipment.fromMap(e)).toList();
    return equipments;
  }
}
