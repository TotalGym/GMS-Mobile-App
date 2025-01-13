import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gmn/data/network/api.dart';

import '../models/trainee/trainee.dart';

class DioHelper {
  DioHelper._();
  static DioHelper io = DioHelper._();

  signIn(String username, String password) {}

  // Future<Trainee>
  Future<String> getTrainee(String userAccessToken, userId) async {
    try {
      Dio dio = Dio();
      dio.options.headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NzI5Mjg4YTQ2YjkwYmVkNjQzMmIyMyIsInJvbGUiOiJTdXBlckFkbWluIiwiaWF0IjoxNzM1OTAyNTg0fQ.yECXTKYcYaQBHWfgN_lz7s8kDCkzzBlvC6zHj9bW_3o',
        'Content-Type': 'application/json'
      };

      Response response = await dio.get(
        '${ApiEndPoints.trainee}6773ebf159f9ad7d493331bc',

        // options: buildCacheOptions(const Duration(days: 1),
        // maxStale: const Duration(days: 3))
      );
      List data;
      log(response.toString());
      return (response.toString());

      if (response.data == '') {
        data = [];
      } else {
        data = response.data;
        log('in get customer in dio the responst .data is : ${data}');
      }
      log(data.toString());
    } catch (e) {
      log(e.toString());
      log('dio_helper.44 | error in getTrainee');
      return (e.toString());
    }
    // return Trainee
  }
}

class TrainerDioHelper {
  TrainerDioHelper._();
  static TrainerDioHelper io = TrainerDioHelper._();

  String baseBakendLink = "";

  signIn(String username, String password) {}

  // List<Trainee> getTrainees(String userAccessToken) {}
  getTrainer(String userAccessToken) {}
}
