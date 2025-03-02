import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gmn/data/network/api.dart';

class DioHelper {
  DioHelper._();
  static DioHelper io = DioHelper._();

  Dio dio = Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Map<String, dynamic>> get({
    token = "",
    model = "",
    id = "",
  }) async {
    dio.options.headers.addAll({'Authorization': '$token'});
    try {
      // print(
      //     "This is the target link: ${ApiHelper.link(modelName: model)} from the get method withing dio_helper");
      Response response = await dio.get(ApiHelper.link(modelName: model));

      print("Data is: ${response.data['data']} inside get withing dio_helper");
      return response.data;
    } catch (e) {
      log("Get Function failed to get responce: $e");
      return Future(() => {});
    }
  }

  // Future<String> post() {}
  // Future<String> put() {}
  // Future<String> delete() {}

  // signIn(String username, String password) {}
  // // Future<Trainee>
  // Future<String> getTrainee(String userAccessToken, userId) async {
  //   try {
  //     Dio dio = Dio();
  //     dio.options.headers = {
  //       'Authorization':
  //           'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3NzI5Mjg4YTQ2YjkwYmVkNjQzMmIyMyIsInJvbGUiOiJTdXBlckFkbWluIiwiaWF0IjoxNzM1OTAyNTg0fQ.yECXTKYcYaQBHWfgN_lz7s8kDCkzzBlvC6zHj9bW_3o',
  //       'Content-Type': 'application/json'
  //     };

  //     Response response = await dio.get(
  //       '${ApiHelper.link(modelName: Trainee.mName)}/6773ebf159f9ad7d493331bc',

  //       //  options:cache buildCacheOptions(const Duration(days: 1),
  //       // maxStale: const Duration(days: 3))
  //     );
  //     log(response.toString());
  //     return (response.toString());

  //     if (response.data == '') {
  //       data = [];
  //     } else {
  //       data = response.data;
  //       log('in get customer in dio the responst .data is : ${data}');
  //     }
  //     log(data.toString());
  //   } catch (e) {
  //     log(e.toString());
  //     log('dio_helper.43 | error in getTrainee');
  //     return (e.toString());
  //   }
  //   // return Trainee
  // }
}
