import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/profile/profile.dart';
import 'package:gmn/data/repositories/user_repos/notification_repo.dart';
import 'package:gmn/data/repositories/user_repos/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  Profile? profile;

  NotificationRepo? notifications;

  int notificationsPage = 1;

  getNotifications(String token) async {
    notifications = await NotificationRepo.getProfileNotifications(token, {
      "page": notificationsPage,
    });
    notifyListeners();
  }

  getProfile(String token) async {
    var profileData = await ProfileRepo.getProfile(token, {});
    profile = profileData;
    log("Profile Provider -> getProfile : $profile");
    notifyListeners();
  }
}
