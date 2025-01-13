class Report {
  late String id;
  late String name;
  late String type;
  late Map<String, dynamic> dataPoints;
  late String date;

  Report(this.id, this.name, this.type, this.dataPoints, this.date);

  Report.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    type = map["type"];
    dataPoints = map["dataPoints"];
    date = map["date"];
  }

  @override
  String toString() {
    return "Report name: $name\ntype: $type\n"
        "Data points: ${dataPoints.toString()}\nDate: $date";
  }
}
