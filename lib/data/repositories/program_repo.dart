import 'dart:developer';

import 'package:gmn/data/models/program/program.dart';
import 'package:gmn/data/network/dio_helper.dart';

class ProgramRepo {
  Future<List<Program>> getAllPrograms() async {
    //ignore: avoid_log
    log("inside programRepo->getAllPrograms");

    Map<String, dynamic> data = await DioHelper.io.get(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWIzMjlmZmExYmUxNTY3MDgyMDI3ZiIsInJvbGUiOiJUcmFpbmVlIiwiaWF0IjoxNzQwODIyNTgyLCJleHAiOjE3NDE0MjczODJ9.DJ9jNiT4rJGsU2urlOCP5OPTgJImM0KBkFdWF0HGVC4",
        Program.mName,
        "nothing",
        '');

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
