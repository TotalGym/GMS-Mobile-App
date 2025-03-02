import 'dart:developer';

import 'package:gmn/data/models/trainee/trainee.dart';
import 'package:gmn/data/network/dio_helper.dart';

class TraineeRepo {
  Future<Trainee> getTrainee() async {
    log("inside TraineeRepo->getTrainee");
    Map<String, dynamic> data = await DioHelper.io.get(
      token:
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWIzMjlmZmExYmUxNTY3MDgyMDI3ZiIsInJvbGUiOiJUcmFpbmVlIiwiaWF0IjoxNzQwODIyNTgyLCJleHAiOjE3NDE0MjczODJ9.DJ9jNiT4rJGsU2urlOCP5OPTgJImM0KBkFdWF0HGVC4",
      model: Trainee.profile,
      id: "nothing",
    );

    log(data['data'].toString());
    log("inside TraineeRepo->getTrainee after");

    //ignore: avoid_print
    print("trainee_repo-> return value is: ${Trainee.fromMap(data['data'])}");

    return Trainee.fromMap(data['data']);
  }

  // Future<String> getAnyResponse() async {
  //   print("inside TraineeRepo->getAnyResponse");
  //   Map<String, dynamic> data = await DioHelper.io.get(
  //     token:
  //         "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWIzMjlmZmExYmUxNTY3MDgyMDI3ZiIsInJvbGUiOiJUcmFpbmVlIiwiaWF0IjoxNzQwODIyNTgyLCJleHAiOjE3NDE0MjczODJ9.DJ9jNiT4rJGsU2urlOCP5OPTgJImM0KBkFdWF0HGVC4",
  //     model: "${Trainee.profile}",
  //     id: "nothing",
  //   );

  //   print("Data is: ${data.toString()} inside trainee_repo-> get any response");
  //   print("inside TraineeRepo->getAnyResponse after calleing get from dio");

  //   return data.toString();
  // }
}
