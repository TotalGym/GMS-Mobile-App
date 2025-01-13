import 'package:gmn/data/models/attendance.dart';
import 'package:gmn/data/models/trainee/membership.dart';
import 'package:gmn/data/models/trainee/trainee_progress_inctance.dart';

class Trainee {
  late String id;
  late MemberShip memberShip;
  late List<String> selectedProgramsIDs = [];
  late List<Attendance> attendance = [];
  late TraineeProgressInstance progress;
  late String name;
  late String email;
  late String phoneNumber;
  late String gender;

  Trainee(
    this.id,
    this.memberShip,
    this.selectedProgramsIDs,
    this.attendance,
    this.progress, {
    this.name = "Unknown Trainee",
    this.email = "NA",
    this.phoneNumber = "NA",
    this.gender = "Undefined",
  });

  Trainee.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    memberShip = MemberShip(
      DateTime(map["membership"]["startDate"]),
      DateTime(map["membership"]["endDate"]),
    );
    selectedProgramsIDs = map["selectedPrograms"];
    attendance = Attendance.getAttendanceList(
      map["attendance"],
    );
    progress = TraineeProgressInstance(
      map["progress"]["milestones"],
      map["progress"]["metrics"],
    );
    name = map["name"] ?? "Unknown Trainee";
    email = map["contact"]["email"] ?? "NA";
    phoneNumber = map["contact"]["phoneNumber"] ?? "NA";
    gender = map["gender"] ?? "Undefined";
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "contact": {"email": email, "phoneNumber": phoneNumber},
      "gender": gender,
      "membership": memberShip,
      "attendance": attendance,
      "selectedPrograms": selectedProgramsIDs,
      "progress": progress
    };
  }

  @override
  String toString() {
    return "\nTrainee name: $name,\nEmail: $email\nMembership:\n ${memberShip.toString()}"
        "\nPrograms: $selectedProgramsIDs"
        "\nAttendace Details:\n $attendance";
  }
}
