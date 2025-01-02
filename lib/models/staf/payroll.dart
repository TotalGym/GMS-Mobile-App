class Payroll {
  late num salary;
  late num bonus;
  late num deduction;
  late DateTime payDay;

  Payroll(this.salary, this.bonus, this.deduction, this.payDay);

  Payroll.fromMap(Map<String, dynamic> map) {
    salary = map["Salary"];
    bonus = map["Bonus"];
    deduction = map["Deductions"];
    payDay = DateTime(map["Date"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "Salary": salary,
      "Bonus": bonus,
      "Deductions": deduction,
      "PayDate": payDay
    };
  }
}
