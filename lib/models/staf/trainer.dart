import 'package:gmn/models/attendance.dart';
import 'package:gmn/models/staf/payroll.dart';
import 'package:gmn/models/trainee/membership.dart';

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
    id = map["ID"];
    name = map["Name"] ?? "Unknown Trainer";
    role = map["Role"] ?? "Trainer";
    attendance = Attendance.getAttendanceList(map["Attendance"]);
    payroll = Payroll.fromMap(map["Payroll"]);
    email = map["Contact"]["Email"] ?? "NA";
    phoneNumber = map["Contact"]["PhoneNumber"] ?? "NA";
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": id,
      "Name": name,
      "Role": role,
      "Contact": {"Email": email, "PhoneNumber": phoneNumber},
      "Attendance": attendance,
      "Payroll": payroll.toMap()
    };
  }

  @override
  String toString() {
    return "\nTrainer name: $name,\nEmail: $email\nMembership:\n"
        "\nPayroll: ${payroll.toString()}"
        "\nAttendace Details:\n $attendance";
  }
}
