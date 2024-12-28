class Report {
  String id;
  String name;
  String type;
  Map<String, dynamic> dataPoints;
  DateTime date;

  Report(this.id, this.name, this.type, this.dataPoints, this.date);

  @override
  String toString() {
    return "Report name: $name\ntype: $type\n"
        "Data points: ${dataPoints.toString()}\nDate: $date";
  }
}
