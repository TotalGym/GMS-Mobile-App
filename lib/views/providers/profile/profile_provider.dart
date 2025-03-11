import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/profile/profile.dart';
import 'package:gmn/data/repositories/user_repos/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  Profile? profile;

  getProfile(String token) async {
    var profileData = await ProfileRepo.getProfile(token, {});
    profile = profileData;
    log("Profile Provider -> getProfile : $profile");
    notifyListeners();
  }

  void reset() {
    profile = null;
    notifyListeners();
  }
}
