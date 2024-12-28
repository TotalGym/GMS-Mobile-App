import 'package:gmn/models/attendance.dart';
import 'package:gmn/models/membership.dart';
import 'package:gmn/models/program.dart';
import 'package:gmn/models/trainee_progress_inctance.dart';

class Trainee {
  String id;
  MemberShip memberShip;
  List<Attendance> attendance = [];
  String name;
  String email;
  String phoneNumber;
  String gender;
  List<Program> selectedPrograms = [];
  TraineeProgressInstance progress;

  Trainee(
    this.id,
    this.memberShip,
    this.selectedPrograms,
    this.attendance,
    this.progress, {
    this.name = "Unknown Trainee",
    this.email = "NA",
    this.phoneNumber = "NA",
    this.gender = "Undefined",
  });

  @override
  String toString() {
    return "\nTrainee name: $name,\nEmail: $email\nMembership:\n ${memberShip.toString()}"
        "\nPrograms: $selectedPrograms";
  }
}
