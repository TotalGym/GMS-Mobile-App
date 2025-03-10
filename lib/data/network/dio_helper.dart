import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gmn/data/network/api.dart';

class DioHelper {
  DioHelper._();
  static DioHelper io = DioHelper._();

  final Dio _dio = Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Map<String, dynamic>> get(String token, String model, String id,
      Map<String, dynamic> queryParameters) async {
    _dio.options.headers.addAll({'Authorization': "Bearer $token"});
    try {
      // ignore: avoid_log
      log("_dioHelper->get headers: ${_dio.options.headers.toString()}");
      // ignore: avoid_log
      log("This is the target link: ${ApiHelper.link(modelName: model)} from the get method withing _dio_helper");
      Response response = await _dio.get(ApiHelper.link(modelName: model),
          queryParameters: queryParameters);

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
    _dio.options.headers.addAll({'Authorization': "Bearer $token"});

    try {
      //ignore: avoid_log
      log("This is the target link: ${ApiHelper.link(modelName: model)} from the post method withing _dio_helper");

      Response response =
          await _dio.post(ApiHelper.link(modelName: model), data: body);

      // ignore: avoid_log
      log("responce is: $response. inside post withing _dio_helper");
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
    _dio.options.headers.addAll({'Authorization': "Bearer $token"});

    try {
      //ignore: avoid_log
      log("This is the target link: ${ApiHelper.link(modelName: model)} from the put method withing _dio_helper");

      Response response =
          await _dio.put(ApiHelper.link(modelName: model), data: body);

      // ignore: avoid_log
      log("responce is: $response. inside post withing _dio_helper");
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
}
