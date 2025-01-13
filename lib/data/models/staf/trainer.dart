import 'package:gmn/data/models/attendance.dart';
import 'package:gmn/data/models/staf/payroll.dart';

class Trainer {
  late String id;
  late String name;
  late String role;
  late List<Attendance> attendance = [];
  late String email;
  late String phoneNumber;
  late Payroll payroll;

  Trainer(
    this.id,
    this.attendance,
    this.payroll, {
    this.role = "Trainer",
    this.name = "Unknown Trainer",
    this.email = "NA",
    this.phoneNumber = "NA",
  });

  Trainer.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    name = map["name"] ?? "Unknown Trainer";
    role = map["role"] ?? "Trainer";
    attendance = Attendance.getAttendanceList(map["attendance"]);
    payroll = Payroll.fromMap(map["payroll"]);
    email = map["contact"]["email"] ?? "NA";
    phoneNumber = map["contact"]["phoneNumber"] ?? "NA";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "role": role,
      "contact": {"email": email, "phoneNumber": phoneNumber},
      "attendance": attendance,
      "payroll": payroll.toMap()
    };
  }

  @override
  String toString() {
    return "\nTrainer name: $name,\nEmail: $email\nMembership:\n"
        "\nPayroll: ${payroll.toString()}"
        "\nAttendace Details:\n $attendance";
  }
}
