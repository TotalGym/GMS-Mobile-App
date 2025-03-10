class Attendance {
  late String id;
  late DateTime date;
  late String? status;

  Attendance(this.date, this.status);

  Attendance.fromMap(Map<String, dynamic> attendace) {
    id = attendace["_id"];
    date = DateTime.parse(attendace["date"]);
    status = attendace["status"];
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "status": status,
    };
  }

  static List getAttendanceList(List? attendaceMapsList) {
    if (attendaceMapsList == null) return [];
    List attendaceList = attendaceMapsList.map((e) {
      return Attendance.fromMap(e);
    }).toList();
    return attendaceList;
  }

  @override
  String toString() {
    return "Date: $date, Status: $status";
  }
}
