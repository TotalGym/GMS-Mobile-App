import 'package:flutter/widgets.dart';
import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationState> notifications = [];
  int notificationsCount = 0;

  getNotifications(String token) async {
    notifications = await TraineeRepo().getAllNotifications(token) ?? [];
    notificationsCount = notifications.length;

    notifyListeners();
  }
}
