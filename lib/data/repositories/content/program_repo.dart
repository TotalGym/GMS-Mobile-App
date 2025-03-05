import 'dart:developer';

import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/data/network/dio_helper.dart';

class ProgramRepo {
  Future<List<Program>> getAllPrograms(String token) async {
    //ignore: avoid_log
    log("inside programRepo->getAllPrograms");

    Map<String, dynamic> data =
        await DioHelper.io.get(token, Program.mName, "nothing", '');

    //ignore: avoid_log
    log(data['data']['results'].toString());

    //ignore: avoid_log
    log("inside ProgramRepo->getAllPrograms after");

    List programMapList = data['data']['results'];

    List<Program> programs = programMapList.map((e) {
      return Program.fromMap(e);
    }).toList();

    //ignore: avoid_log
    log("Programs are: $programs");

    return programs;
  }
}
