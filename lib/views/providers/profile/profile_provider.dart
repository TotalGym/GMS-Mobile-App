import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/repositories/user_repos/notification_repo.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class ProfileProvider extends ChangeNotifier {
  Trainee? trainee;

  NotificationRepo? notifications;

  int notificationsPage = 1;

  getNotifications(String token) async {
    notifications = await NotificationRepo.getTraineeNotifications(token, {
      "page": notificationsPage,
    });
    notifyListeners();
  }

  getTraineeProfile(String token) async {
    var traineeProfile = await TraineeRepo.getTrainee(token, {});
    log("User_provider-> getTraineeProfile : $traineeProfile");
    trainee = traineeProfile;
  }
}
