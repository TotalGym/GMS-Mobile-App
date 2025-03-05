import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class ProfileProvider extends ChangeNotifier {
  Trainee? trainee;

  TraineeRepo? notifications;
  int notificationsCount = 0;

  getNotifications(String token) async {
    notifications = await TraineeRepo.getTraineeNotifications(token);
    notifications != null
        ? notificationsCount = notifications!.items!.length
        : {};
    notifyListeners();
  }

  getTraineeProfile(String token) async {
    var traineeProfile = await TraineeRepo.getTrainee(token);
    log("User_provider-> getTraineeProfile : $traineeProfile");
    trainee = traineeProfile;
  }
}
