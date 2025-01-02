class Attendance {
  late DateTime date;
  late String? status;

  Attendance(this.date, this.status);

  Attendance.fromMap(Map<String, dynamic> attendace) {
    date = DateTime(attendace["Date"]);
    status = attendace["Status"];
  }

  Map<String, dynamic> toMap() {
    return {
      "Date": date,
      "Status": status,
    };
  }

  static List<Attendance> getAttendanceList(
      List<Map<String, dynamic>> attendanceMap) {
    List<Attendance> attendaceList = attendanceMap.map((e) {
      return Attendance.fromMap(e);
    }).toList();

    return attendaceList;
  }

  @override
  String toString() {
    return "Date: $date, Status: $status";
  }
}
