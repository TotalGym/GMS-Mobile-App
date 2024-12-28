class Exercise {
  String name;
  String sets;
  int repetitions;

  Exercise(this.name, this.sets, this.repetitions);

  @override
  String toString() {
    return "Exercise name is: $name, with $sets of $repetitions times.";
  }
}
