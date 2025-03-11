import 'package:flutter/material.dart';
import 'package:gmn/data/helpers/shared_preferences_helper.dart';
import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/repositories/user_repos/notification_repo.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationRepo? notifications;
  int notificationsPage = 1;

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
    notifications = await NotificationRepo.getProfileNotifications(token, {
      "page": notificationsPage,
    });
    notifyListeners();
  }

  void reset() {
    notifications = null;
    notificationsPage = 1;
    notifyListeners();
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
        await SharedPreferencesHelper.instance
            .addViewedNotificationID(e.id ?? '');
        return e.viewByUser = false;
      }
    }).toList();

    return notifications;
  }
}
