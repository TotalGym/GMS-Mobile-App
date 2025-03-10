import 'package:flutter/material.dart';
import 'package:gmn/data/repositories/content/equipment_repo.dart';
import 'package:gmn/data/repositories/user_repos/notification_repo.dart';
import 'package:gmn/data/repositories/user_repos/profile_repo.dart';

class CoachProvider extends ChangeNotifier {
  ProfileRepo? traineeProfiles;
  int traineeProfilesPage = 1;

  EquipmentRepo? equipments;
  int equipmentsPage = 1;

  getAllProfiles(String token) async {
    if (traineeProfiles == null) {
      traineeProfiles =
          await ProfileRepo.getProfiles(token, {"page": traineeProfilesPage});
    } else {
      ProfileRepo tempTrainess =
          await ProfileRepo.getProfiles(token, {"page": traineeProfilesPage});
      traineeProfiles!.update(tempTrainess);
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
    await getAllProfiles(token);
    await getNotifications(token);
  }

  Future<void> getProfilesNextPage(String token) async {
    if (traineeProfiles!.next == null) {
      return;
    }
    traineeProfilesPage++;
    await getAllProfiles(token);
    return;
  }

  void resetProfiles() {
    traineeProfiles = null;
    traineeProfilesPage = 1;
    notifyListeners();
  }

  Future<void> getEquipmentsNextPage(String token) async {
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
