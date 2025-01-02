class Exercise {
  late String name;
  late String sets;
  late int repetitions;

  Exercise(this.name, this.sets, this.repetitions);

  Exercise.fromMap(Map<String, dynamic> map) {
    name = map[]
  }

  static List<Exercise> getExercisesList(
      List<Map<String, dynamic>> exerciseMap) {
    List<Exercise> attendaceList = exerciseMap.map((e) {
      return Exercise.fromMap(e);
    }).toList();

    return attendaceList;
  }

  @override
  String toString() {
    return "Exercise name is: $name, with $sets of $repetitions times.";
  }
}
