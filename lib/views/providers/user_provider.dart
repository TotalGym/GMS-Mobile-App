import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/repositories/shared_preferences_helper.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';
import 'package:gmn/data/repositories/user_repos/user_repo.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  String? token;
  bool? isLoggedIn;
  Trainee? traineeProfile;

  Future<void> checkIfLoggedIn() async {
    String? token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    isLoggedIn = token != null ? true : false;
    isLoggedIn! ? getUser(token!) : {};
    notifyListeners();
  }

  getUser(String token) async {
    if (isLoggedIn! && user == null) {
      user = await UserRepo.getUser(token);

      log("UserProvider-> checkIfLoggedIn user: ${user!.email}");
      this.token = user!.token;

      traineeProfile = await getTraineeProfile(token);
    }
    notifyListeners();
  }

  logUserIn(String email, String password) async {
    user = await UserRepo.login(email, password);
    token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    isLoggedIn = token != null;

    if (isLoggedIn != null) {
      isLoggedIn! ? traineeProfile = await getTraineeProfile(token!) : {};
    }
    notifyListeners();
  }

  getTraineeProfile(String token) async {
    var traineeProfile = TraineeRepo().getTrainee(token);
    log("User_provider-> getTraineeProfile : $traineeProfile");
    return traineeProfile;
  }

  logUserOut() async {
    await UserRepo.logOut();
    user = null;
    token = null;
    isLoggedIn = false;
    notifyListeners();
  }

  changePassword(String oldPassword, String newPassword) async {
    await user?.chagePassword(
      oldPassword,
      newPassword,
    );
  }
}
