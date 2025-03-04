import 'dart:developer';

import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/network/dio_helper.dart';

class TraineeRepo {
  Future<Trainee> getTrainee(String token) async {
    Map data = await DioHelper.io.get(token, Trainee.profile, '', '');

    log("trainee_repo-> return value is: $data");

    Trainee trainee = Trainee.fromMap(data['data']);

    return trainee;
  }
}
