class Exercise {
  static String mName = "exercise";

  late String id;
  late String name;
  late String sets;
  late int repetitions;

  Exercise(this.name, this.sets, this.repetitions);

  Exercise.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    name = map["name"];
    sets = map["sets"];
    repetitions = map["repetisions"];
  }

  static List<Exercise> getExercisesList(
      List<Map<String, dynamic>> exerciseMap) {
    List<Exercise> exercisesList = exerciseMap.map((e) {
      return Exercise.fromMap(e);
    }).toList();

    return exercisesList;
  }

  @override
  String toString() {
    return "Exercise name is: $name, with $sets of $repetitions times.";
  }
}
