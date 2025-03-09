import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class ProgramRepo extends Repo<Program> {
  static const String mName = "programs";

  ProgramRepo.fromMap(Map map) {
    super.fromMap(map);
  }

  @override
  void update(Repo tempRepo) {
    super.update(tempRepo);
  }

  static Future<ProgramRepo> getAllPrograms(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce = await DioHelper.io.get(token, mName, '', queryParameter);
    Map responceData = responce["data"];

    List<Program> programs = await loadPrograms(responceData);

    Map programRepoMap = {
      'totalCount': responceData['totalCount'],
      'page': responceData['page'],
      'limit': responceData['limit'],
      'next': responceData['next'],
      'items': programs,
    };

    ProgramRepo equipmentRepo = ProgramRepo.fromMap(programRepoMap);

    return equipmentRepo;
  }

  static Future<List<Program>> loadPrograms(Map data) async {
    List<Program> programs = [];
    List programMapList = data["results"];
    programs = programMapList.map((e) => Program.fromMap(e)).toList();
    return programs;
  }
}
