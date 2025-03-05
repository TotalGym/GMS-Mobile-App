import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class ProgramRepo extends Repo<Program> {
  static const String mName = "store";

  ProgramRepo.fromMap(Map map) {
    super.fromMap(map);
  }

  @override
  void update(Repo tempRepo) {
    super.update(tempRepo);
  }

  static Future<ProgramRepo> getAllPrograms(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce = await DioHelper.io.get(
      token,
      mName,
      '',
      queryParameter,
    );
    Map responceData = responce["data"];

    List<Program> equipments = await loadPrograms(responceData);

    Map equipmentRepoMap = {
      'totalCount': responceData['totalCount'],
      'page': responceData['page'],
      'limit': responceData['limit'],
      'next': responceData['next'],
      'items': equipments,
    };

    ProgramRepo equipmentRepo = ProgramRepo.fromMap(equipmentRepoMap);

    return equipmentRepo;
  }

  static Future<List<Program>> loadPrograms(Map data) async {
    List<Program> equipments = [];
    List equipmentsMapList = data["results"];
    equipments = equipmentsMapList.map((e) => Program.fromMap(e)).toList();
    return equipments;
  }
}
