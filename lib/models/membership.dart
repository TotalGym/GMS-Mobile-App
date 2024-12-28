class MemberShip {
  DateTime startDate;
  DateTime endDate;
  MemberShip(this.startDate, this.endDate);

  @override
  String toString() {
    return "Membership starts on: $startDate\n Membership ends on: $endDate";
  }
}
