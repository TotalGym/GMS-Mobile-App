import 'dart:developer';

import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/network/dio_helper.dart';

class TraineeRepo {
  Future<Trainee> getTrainee(String token) async {
    Map data = await DioHelper.io.get(token, Trainee.profile, '', '');

    log("trainee_repo-> return value is: $data");

    Trainee trainee = Trainee.fromMap(data['data']);

    return trainee;
  }

  Future<List<Trainee>> getAllTrainees(String token) async {
    Map data = await DioHelper.io.get(token, Trainee.mName, '', '');

    log("trainee_repo -> getAllTrainees data from get is: $data");

    List traineesMapList = data['data']['results'];

    List<Trainee> trainees = traineesMapList.map((e) {
      return Trainee.fromMap(e);
    }).toList();

    log("trainee_repo -> getAllTainees: $trainees");

    return trainees;
  }

  Future<List<NotificationState>> getTraineeNotifications(String token) async {
    Map data = await DioHelper.io
        .get(token, NotificationState.mTraineeNotificationsName, '', '');
    List<Map> notificationsMapList = data["results"];

    List<NotificationState> notificationsList = [];
    notificationsList = notificationsMapList.map((e) {
      return NotificationState.fromMap(e);
    }).toList();

    return notificationsList;
  }

  Future<List<NotificationState>>? getAllNotifications(String token) async {
    Map response =
        await DioHelper.io.get(token, NotificationState.mName, "", "");
    List notificationsMapList = response["data"]["results"];

    List<NotificationState> notificationsList = [];
    notificationsList = notificationsMapList.map((e) {
      return NotificationState.fromMap(e);
    }).toList();

    return notificationsList;
  }
}
