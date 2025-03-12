import 'package:flutter/material.dart';
import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/helpers/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/profile/notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationRepo extends Repo<NotificationState> {
  NotificationRepo.fromMap(Map map) {
    try {
      totalCount = map['totalCount'];
      page = map['page'];
      limit = map['limit'];
      next = map['next']; // Map<String, dynamic>.from(map['next']) : null;
      items = map["items"];
    } catch (e) {
      //
    }
  }

  static Future<NotificationRepo> getProfileNotifications(
      String token, Map<String, dynamic> queryParameter) async {
    Map respnce = await DioHelper.io.get(
        token, NotificationState.mProfileNotificationsName, '', queryParameter);
    Map data = respnce["data"] ?? {};

    List<NotificationState> notifications =
        loadNotifications(data, NotificationState.mProfileNotificationsName);

    Map notificationRepoMap = {
      'totalCount': data['totalCount'],
      'page': data['page'],
      'limit': data['limit'],
      'next': data['next'],
      'items': notifications,
    };

    NotificationRepo notificationRepo =
        NotificationRepo.fromMap(notificationRepoMap);

    return notificationRepo;
  }

  static Future<NotificationRepo> getCoachNotifications(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce = await DioHelper.io
        .get(token, NotificationState.mName, '', queryParameter);
    Map data = responce["data"];

    List<NotificationState> notifications =
        loadNotifications(data, NotificationState.mName);

    Map notificationRepoMap = {
      'totalCount': data['totalCount'],
      'page': data['page'],
      'limit': data['limit'],
      'next': data['next'],
      'items': notifications,
    };

    NotificationRepo traineeRepo =
        NotificationRepo.fromMap(notificationRepoMap);

    return traineeRepo;
  }

  static List<NotificationState> loadNotifications(Map data, String modelName) {
    List notificationsMapList = data["results"] ?? [];

    List<NotificationState> notificationsList = [];
    notificationsList = notificationsMapList.map((e) {
      return NotificationState.fromMap(e);
    }).toList();

    return notificationsList;
  }

  static updateNotifications(User user) {
    BuildContext context = AppRouter.navKey.currentContext!;
    user.role == "Coach"
        ? context
            .read<NotificationProvider>()
            .getCoachNotifications(user.token!)
        : context
            .read<NotificationProvider>()
            .getProfileNotifications(user.token!);
  }
}
