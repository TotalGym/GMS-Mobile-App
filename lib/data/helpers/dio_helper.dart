import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gmn/data/network/api.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:provider/provider.dart';

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

    final cacheManager = DefaultCacheManager();

    String cacheKey =
        "${ApiHelper.link(modelName: model)}_${queryParameters.toString()}";
    bool online = AppRouter.navKey.currentContext!.read<UserProvider>().online;

    String offlineCachekey = cacheKey;

    if (online) {
      log('User is online');
      cacheKey = "${cacheKey}_online";
    }

    try {
      // 🔍 Check if cached data exists
      final fileInfo = await cacheManager.getFileFromCache(cacheKey);

      log('CachKey is: $cacheKey');

      if (fileInfo != null &&
          fileInfo.validTill.isAfter(DateTime.now()) &&
          !_isNotification(cacheKey)) {
        String cachedData = await fileInfo.file.readAsString();
        log("Loaded from cache: $cachedData");
        return jsonDecode(cachedData);
      }

      // Fetch from API if cache is missing or expired
      log("_dioHelper->get headers: ${_dio.options.headers.toString()}");
      log("Fetching from API: ${ApiHelper.link(modelName: model)}");

      Response response = await _dio.get(ApiHelper.link(modelName: model),
          queryParameters: queryParameters);

      log("DioHelper-> get Data is: ${response.data['data']}");

      Map<String, dynamic>? data = response.data;
      if (data != null) {
        //  Save response to cache with maxAge of 7 days to retrieve when offline
        await cacheManager.putFile(
            offlineCachekey,
            Uint8List.fromList(
              utf8.encode(
                jsonEncode(data),
              ),
            ),
            maxAge: const Duration(days: 7));

        //save response to cache with maxAge of 30 minutes to retrieve when online
        await cacheManager.putFile(
            "${cacheKey}_online",
            Uint8List.fromList(
              utf8.encode(
                jsonEncode(data),
              ),
            ),
            maxAge: const Duration(minutes: 30));

        return data;
      } else {
        throw Exception("Did not get a response from the server");
      }
    } catch (e) {
      log("Get Function failed to get response: $e");
      return {};
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
        return {"success": false};
      }
    } catch (e) {
      log("put Function failed to get responce: $e");
      return {"success": false};
    }
  }

//This method checks if the cacheKey contains a notifications requist
//if the user is online.. the method prevents him from showing cached notification
//however he can show thim when offline.
  _isNotification(String cacheKey) {
    bool online = AppRouter.navKey.currentContext!.read<UserProvider>().online;
    if (!cacheKey.contains("otification")) {
      if (online) {
        return true;
      }
    }
    return false;
  }
}
