import 'package:flutter/material.dart';
import 'package:gmn/data/helpers/shared_preferences_helper.dart';
import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/repositories/user_repos/notification_repo.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationRepo? notifications;
  int notificationsPage = 1;
  bool hasNewNotifications = false;

  bool isLoading = false;

  getCoachNotifications(String token) async {
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
    notifications!.items = await _checkIfViewedByUser(notifications!.items!);
    isLoading = false;
    notifyListeners();
  }

  getCoachNotificationsNextPage(String token) async {
    if (notifications!.next == null) {
      return;
    }
    notificationsPage++;
    await getCoachNotifications(token);
  }

  getProfileNotificationsNextPage(String token) async {
    if (notifications!.next == null) {
      return;
    }
    notificationsPage++;
    await getProfileNotifications(token);
  }

  getProfileNotifications(String token) async {
    if (notifications == null) {
      notifications = await NotificationRepo.getProfileNotifications(token, {
        "page": notificationsPage,
      });
    } else {
      NotificationRepo tempNotifications =
          await NotificationRepo.getProfileNotifications(token, {
        "page": notificationsPage,
      });
      notifications!.update(tempNotifications);
    }
    try {
      notifications!.items = await _checkIfViewedByUser(notifications!.items!);
    } catch (e) {
      notifications!.items = [];
    }
    isLoading = false;
    notifyListeners();
  }

  void reset() {
    notifications = null;
    notificationsPage = 1;
    notifyListeners();
  }

  void deleteAll() {
    notifications = null;
    isLoading = true;
  }

  Future<List<NotificationState>> _checkIfViewedByUser(
      List<NotificationState> notifications) async {
    List<String?> notificationsIDsFromSP = await SharedPreferencesHelper
            .instance
            .getStringList('notifications_ids') ??
        [];

    notifications.map((e) async {
      if (notificationsIDsFromSP.contains(e.id)) {
        return e.viewByUser = true;
      } else {
        hasNewNotifications = true;
        notifyListeners();
        await SharedPreferencesHelper.instance
            .addViewedNotificationID(e.id ?? '');
        return e.viewByUser = false;
      }
    }).toList();

    return notifications;
  }

  setNoNewNotifications() {
    hasNewNotifications = false;
    notifyListeners();
  }
}
