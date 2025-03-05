import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/repositories/content/equipment_repo.dart';
import 'package:gmn/data/repositories/user_repos/notification_repo.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class CoachProvider extends ChangeNotifier {
  TraineeRepo? trainees;
  int traineesPage = 1;

  EquipmentRepo? equipments;
  int equipmentsPage = 1;

  getAllTrainees(String token) async {
    if (trainees == null) {
      trainees = await TraineeRepo.getTrainees(token, {"page": traineesPage});
    } else {
      TraineeRepo tempTrainess =
          await TraineeRepo.getTrainees(token, {"page": traineesPage});
      trainees!.update(tempTrainess);
    }
    notifyListeners();
  }

  getAllEquipments(String token) async {
    if (equipments == null) {
      equipments =
          await EquipmentRepo.getAllEquipments(token, {"page": equipmentsPage});
    } else {
      EquipmentRepo tempEquipments =
          await EquipmentRepo.getAllEquipments(token, {"page": equipmentsPage});
      equipments!.update(tempEquipments);
    }
    notifyListeners();
  }

  NotificationRepo? notifications;
  int notificationsPage = 1;

  getNotifications(String token) async {
    if (notifications == null) {
      notifications = await NotificationRepo.getCoachNotifications(token, {
        "page": notificationsPage,
      });
    } else {
      NotificationRepo tempNotifications =
          await NotificationRepo.getCoachNotifications(token, {
        "page": notificationsPage,
      });
      notifications!.update(tempNotifications);
    }

    notifyListeners();
  }

  loadAll(String token) async {
    await getAllEquipments(token);
    await getAllTrainees(token);
    await getNotifications(token);
  }

  void getTraineesNextPage(String token) async {
    if (trainees!.next == null) {
      return;
    }
    traineesPage++;
    await getAllTrainees(token);
  }

  void resetTrainees() {
    trainees = null;
    traineesPage = 1;
    notifyListeners();
  }

  void getEquipmentsNextPage(String token) async {
    if (equipments!.next == null) {
      return;
    }
    equipmentsPage++;
    await getAllEquipments(token);
  }

  void resetEquipments() {
    equipments = null;
    equipmentsPage = 1;
    notifyListeners();
  }

  void getNotificationsNextPage(String token) async {
    if (notifications!.next == null) {
      return;
    }
    notificationsPage++;
    await getNotifications(token);
  }

  void resetNotifications() {
    notifications = null;
    notificationsPage = 1;
    notifyListeners();
  }
}
