import 'package:gmn/data/models/program/program.dart';
import 'package:gmn/data/network/dio_helper.dart';

class ProgramRepo {
  Future<List<Program>> getAllPrograms() async {
    //ignore: avoid_print
    print("inside programRepo->getAllPrograms");

    Map<String, dynamic> data = await DioHelper.io.get(
      token:
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWIzMjlmZmExYmUxNTY3MDgyMDI3ZiIsInJvbGUiOiJUcmFpbmVlIiwiaWF0IjoxNzQwODIyNTgyLCJleHAiOjE3NDE0MjczODJ9.DJ9jNiT4rJGsU2urlOCP5OPTgJImM0KBkFdWF0HGVC4",
      model: Program.mName,
      id: "nothing",
    );

    //ignore: avoid_print
    print(data['data']['results'].toString());

    //ignore: avoid_print
    print("inside ProgramRepo->getAllPrograms after");

    List programMapList = data['data']['results'];

    List<Program> programs = programMapList.map((e) {
      //ignore: avoid_print
      print("program_repo-> return value is: $e");

      //ignore: avoid_print
      print("program_repo-> return value as product is: ${Program.fromMap(e)}");
      return Program.fromMap(e);
    }).toList();

    //ignore: avoid_print
    print("Programs are: $programs");

    return programs;
  }
}
