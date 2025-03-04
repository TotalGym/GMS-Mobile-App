class Payroll {
  late num salary;
  late num bonus;
  late num deduction;
  late DateTime payDay;

  Payroll(this.salary, this.bonus, this.deduction, this.payDay);

  Payroll.fromMap(Map<String, dynamic> map) {
    salary = map["salary"];
    bonus = map["bonus"];
    deduction = map["deductions"];
    payDay = DateTime(map["payDate"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "salary": salary,
      "bonus": bonus,
      "deductions": deduction,
      "payDate": payDay
    };
  }

  @override
  String toString() {
    return "${toMap()}";
  }
}
