import 'package:gmn/data/repositories/user_repos/trainee_repo.dart';

class NotificationState {
  static const String mName = "notification";
  static const String mTraineeNotificationsName = "traineeNotifications";

  String? id;
  String? userID;
  String? userType;
  String? type;
  String? content;
  DateTime? date;

  NotificationState.fromMap(Map map) {
    id = map["_id"] ?? "NA";
    userID = map["UserID"] ?? "NA";
    userType = map["UserType"] ?? "NA";
    type = map["Type"] ?? "NA";
    content = map["Content"] ?? "NA";
    date = DateTime.parse(map["Date"] ?? "2025-03-31T22:00:00.000Z");
  }

  @override
  String toString() {
    return "Notification type: $type, content: $content, date = $date";
  }
}
