import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class NotificationRepo extends Repo<NotificationState> {
  NotificationRepo.fromMap(Map map) {
    totalCount = map['totalCount'];
    page = map['page'];
    limit = map['limit'];
    next =
        map['next'] != null ? Map<String, dynamic>.from(map['next']) : {"": ""};
    items = map["items"];
  }

  static Future<NotificationRepo> getProfileNotifications(
      String token, Map<String, dynamic> queryParameter) async {
    Map respnce = await DioHelper.io.get(
        token, NotificationState.mProfileNotificationsName, '', queryParameter);
    Map data = respnce["data"];

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
    List notificationsMapList = data["results"];

    List<NotificationState> notificationsList = [];
    notificationsList = notificationsMapList.map((e) {
      return NotificationState.fromMap(e);
    }).toList();

    return notificationsList;
  }
}
