import 'package:flutter/material.dart';
import 'package:gmn/data/models/content/equipment/equipment.dart';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/repositories/content/equipment_repo.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class CoachProvider extends ChangeNotifier {
  List<Trainee>? trainees;
  int traineesCount = 0;

  List<Equipment>? equipments;
  int equipmentsCount = 0;

  getAllTrainees(String token) async {
    trainees = await TraineeRepo().getAllTrainees(token);
    trainees != null ? traineesCount = trainees!.length : {};
    notifyListeners();
  }

  getAllEquipments(String token) async {
    equipments = await EquipmentRepo().getAllEquipments(token);
    equipments != null ? equipmentsCount = equipments!.length : {};
    notifyListeners();
  }

  loadAll(String token) async {
    await getAllEquipments(token);
    await getAllTrainees(token);
  }
}
