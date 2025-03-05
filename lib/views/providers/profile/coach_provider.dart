import 'package:flutter/material.dart';
import 'package:gmn/data/repositories/content/equipment_repo.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class CoachProvider extends ChangeNotifier {
  TraineeRepo? trainees;
  int traineesCount = 0;

  EquipmentRepo? equipments;
  int equipmentsCount = 0;

  getAllTrainees(String token) async {
    trainees = await TraineeRepo.getTrainees(token);
    trainees != null ? traineesCount = trainees!.items!.length : {};
    notifyListeners();
  }

  getAllEquipments(String token) async {
    equipments = await EquipmentRepo.getAllEquipments(token);
    equipments != null ? equipmentsCount = equipments!.items!.length : {};
    notifyListeners();
  }

  TraineeRepo? notifications;
  int notificationsCount = 0;

  getNotifications(String token) async {
    notifications = await TraineeRepo.getCoachNotifications(token);
    notifications != null
        ? notificationsCount = notifications!.items!.length
        : {};
    notifyListeners();
  }

  loadAll(String token) async {
    await getAllEquipments(token);
    await getAllTrainees(token);
    await getNotifications(token);
  }
}
