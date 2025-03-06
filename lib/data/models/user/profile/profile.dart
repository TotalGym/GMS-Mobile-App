import 'package:gmn/data/models/user/extentions/attendance.dart';

class Profile {
  static String profile = "profile";
  static String trainee = "trainee";

  String? id;
  List? attendance = [];
  String? name;
  String? email;
  String? contactEmail;
  String? phoneNumber;
  String? role;
  String? status;
  Map? membership;
  Map<String, dynamic>? progress;
  List? assignedCoaches;
  String? gender;
  List? selectedPrograms;
  DateTime? createdAt;

  Profile.fromMap(Map<String, dynamic> map) {
    if (map.isNotEmpty) {
      id = map["_id"];
      attendance = Attendance.getAttendanceList(map["attendance"]);
      name = map["name"] ?? "Name unknown";
      email = map["email"] ?? "NA";
      contactEmail = map["contact"]["email"];
      phoneNumber = map["contact"]["phoneNumber"] ?? "NA";
      role = map["role"] ?? "Trainee";
      status = map["status"] ?? "new";
      membership = map["membership"] ?? {};
      progress = getProgressMap(map["progress"]);
      assignedCoaches = map["assignedCoach"] ?? [];
      gender = map["gender"] ?? "unknown";
      selectedPrograms = map["selectedPrograms"];
      createdAt =
          DateTime.parse(map["createdAt"] ?? '1970-12-31T13:04:49.970Z');
    }
  }
  Map<String, dynamic>? getProgressMap(Map? map) {
    if (map != null) {
      return {
        "milestones": [map["milesgones"]],
        "metrics": map["metrics"],
      };
    }
    return null;
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
    return "$id";
  }
  // @override
  // String toString() {
  //   return "\nTrainee name: $name,\nEmail: $contactEmail\nAttendace Details:\n $attendance\n"
  //       "role: $role\nGender: $gender";
  // }
}
