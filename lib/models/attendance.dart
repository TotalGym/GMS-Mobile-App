class Attendance {
  DateTime date;
  String? status;

  Attendance(this.date, this.status);

  @override
  String toString() {
    return "Trainee attendance status is: $status\nDate is: $date}";
  }
}
