import 'package:gmn/data/models/attendance.dart';

class Trainee {
  static String profile = "profile";
  static String mName = "trainee";

  late List attendance = [];
  late String name;
  late String email;
  late String phoneNumber;
  late String role;
  late String status;

  Trainee(this.attendance,
      {this.name = "Unknown Trainee",
      this.email = "NA",
      this.phoneNumber = "NA",
      this.role = 'Trainee',
      this.status = 'new'});

  Trainee.fromMap(Map<String, dynamic> map) {
    if (map.isNotEmpty) {
      attendance = Attendance.getAttendanceList(
        map["attendance"] ?? [{}],
      );

      name = map["name"] ?? "Unknown Trainee";
      email = map["email"] ?? "NA";
      phoneNumber = map["contact"]["phoneNumber"] ?? "NA";
      role = map["role"] ?? "Trainee";
      status = map["status"] ?? "new";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "contact": {"email": email, "phoneNumber": phoneNumber},
      "role": role,
      "status": status,
      "attendance": attendance,
    };
  }

  @override
  String toString() {
    return "\nTrainee name: $name,\nEmail: $email\nAttendace Details:\n $attendance";
  }
}
