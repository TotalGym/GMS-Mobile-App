import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gmn/data/network/api.dart';

class DioHelper {
  DioHelper._();
  static DioHelper io = DioHelper._();

  Dio dio = Dio(
    BaseOptions(
        // headers: {'Content-Type': 'application/json'},
        ),
  );

  Future<Map<String, dynamic>> get(
      String token, String model, String id, String queryParameters) async {
    dio.options.headers.addAll({'Authorization': "Bearer $token"});
    try {
      // ignore: avoid_log
      log("dioHelper->get headers: ${dio.options.headers.toString()}");
      // ignore: avoid_log
      log("This is the target link: ${ApiHelper.link(modelName: model)} from the get method withing dio_helper");
      Response response = await dio.get(ApiHelper.link(modelName: model));

      // ignore: avoid_log
      log("DioHelper-> get Data is: ${response.data['data']}");

      Map<String, dynamic>? data = response.data;
      if (data != null) {
        return data;
      } else {
        throw Exception("Did not get a responce from the server");
      }
    } catch (e) {
      log("Get Function failed to get responce: $e");
      return Future(() => {});
    }
  }

  Future<Map> post(
      String token, Map body, String model, String queryParameters) async {
    dio.options.headers.addAll({'Authorization': "Bearer $token"});

    try {
      //ignore: avoid_log
      log("This is the target link: ${ApiHelper.link(modelName: model)} from the post method withing dio_helper");

      Response response =
          await dio.post(ApiHelper.link(modelName: model), data: body);

      // ignore: avoid_log
      log("responce is: $response. inside post withing dio_helper");
      if (response.data["success"] == true) {
        return response.data;
      } else {
        return {};
      }
    } catch (e) {
      log("Get Function failed to get responce: $e");
      return Future(() => {});
    }
  }

  Future<Map> put(
      String token, Map body, String model, String queryParameters) async {
    dio.options.headers.addAll({'Authorization': "Bearer $token"});

    try {
      //ignore: avoid_log
      log("This is the target link: ${ApiHelper.link(modelName: model)} from the put method withing dio_helper");

      Response response =
          await dio.put(ApiHelper.link(modelName: model), data: body);

      // ignore: avoid_log
      log("responce is: $response. inside post withing dio_helper");
      if (response.data["success"] == true) {
        return response.data;
      } else {
        return {};
      }
    } catch (e) {
      log("put Function failed to get responce: $e");
      return Future(() => {});
    }
  }

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
