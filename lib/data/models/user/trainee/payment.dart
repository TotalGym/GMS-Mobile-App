class Payment {
  late String id;
  late int amount;
  late String status;
  late DateTime dueDate;
  late DateTime paymentDate;

  Payment(this.id, this.amount, this.status, this.dueDate, this.paymentDate);

  Payment.fromMap(Map<String, dynamic> map) {
    id = map[""];
  }
}
