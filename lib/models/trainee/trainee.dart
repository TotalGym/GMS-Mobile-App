import 'package:gmn/models/attendance.dart';
import 'package:gmn/models/trainee/membership.dart';
import 'package:gmn/models/trainee/trainee_progress_inctance.dart';

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
    id = map["ID"];
    memberShip = MemberShip(
      DateTime(map["Membership"]["StartDate"]),
      DateTime(map["Membership"]["EndDate"]),
    );
    selectedProgramsIDs = map["SelectedPrograms"];
    attendance = Attendance.getAttendanceList(
      map["Attendance"],
    );
    progress = TraineeProgressInstance(
      map["Progress"]["Milestones"],
      map["Progress"]["Metrics"],
    );
    name = map["Name"] ?? "Unknown Trainee";
    email = map["Contact"]["Email"] ?? "NA";
    phoneNumber = map["Contact"]["PhoneNumber"] ?? "NA";
    gender = map["Gender"] ?? "Undefined";
  }

  Map<String, dynamic> toMap() {
    return {
      "ID": id,
      "Name": name,
      "Contact": {"Email": email, "PhoneNumber": phoneNumber},
      "Gender": gender,
      "Membership": memberShip,
      "Attendance": attendance,
      "SelectedPrograms": selectedProgramsIDs,
      "Progress": progress
    };
  }

  @override
  String toString() {
    return "\nTrainee name: $name,\nEmail: $email\nMembership:\n ${memberShip.toString()}"
        "\nPrograms: $selectedProgramsIDs"
        "\nAttendace Details:\n $attendance";
  }
}
