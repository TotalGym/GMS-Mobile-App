import 'dart:developer';

import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class TraineeRepo extends Repo<Trainee> {
  TraineeRepo.fromMap(Map map) {
    totalCount = map['totalCount'];
    page = map['page'];
    limit = map['limit'];
    next =
        map['next'] != null ? Map<String, dynamic>.from(map['next']) : {"": ""};
    items = map["items"];
  }

  static Future<TraineeRepo> getTrainees(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce =
        await DioHelper.io.get(token, Trainee.mName, "", queryParameter);
    Map data = responce["data"];

    List<Trainee> trainees = loadTrainees(data);

    Map traineeRepoMap = {
      'totalCount': data['totalCount'],
      'page': data['page'],
      'limit': data['limit'],
      'next': data['next'],
      'items': trainees,
    };

    TraineeRepo traineeRepo = TraineeRepo.fromMap(traineeRepoMap);

    return traineeRepo;
  }

  static Future<Trainee> getTrainee(
      String token, Map<String, dynamic> queryParameter) async {
    Map data =
        await DioHelper.io.get(token, Trainee.profile, '', queryParameter);

    log("trainee_repo-> return value is: $data");

    Trainee trainee = Trainee.fromMap(data['data']);

    return trainee;
  }

  static List<Trainee> loadTrainees(Map data) {
    List traineesMapList = data['results'];

    List<Trainee> trainees = traineesMapList.map((e) {
      return Trainee.fromMap(e);
    }).toList();

    return trainees;
  }

  static Future<TraineeRepo> getTraineeNotifications(
      String token, Map<String, dynamic> queryParameter) async {
    Map respnce = await DioHelper.io.get(
        token, NotificationState.mTraineeNotificationsName, '', queryParameter);
    Map data = respnce["data"];

    List<NotificationState> notifications =
        loadNotifications(data, NotificationState.mTraineeNotificationsName);

    Map notificationRepoMap = {
      'totalCount': data['totalCount'],
      'page': data['page'],
      'limit': data['limit'],
      'next': data['next'],
      'items': notifications,
    };

    TraineeRepo notificationRepo = TraineeRepo.fromMap(notificationRepoMap);

    return notificationRepo;
  }

  static Future<TraineeRepo> getCoachNotifications(
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

    TraineeRepo traineeRepo = TraineeRepo.fromMap(notificationRepoMap);

    return traineeRepo;
  }

  static List<NotificationState> loadNotifications(Map data, String modelName) {
    List<Map> notificationsMapList = data["results"];

    List<NotificationState> notificationsList = [];
    notificationsList = notificationsMapList.map((e) {
      return NotificationState.fromMap(e);
    }).toList();

    return notificationsList;
  }
}
