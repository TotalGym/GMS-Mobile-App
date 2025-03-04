import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class CoachProvider extends ChangeNotifier {
  List<Trainee>? trainees;

  getAllTrainees(token) async {
    trainees = await TraineeRepo().getAllTrainees(token);
    notifyListeners();
  }
}
