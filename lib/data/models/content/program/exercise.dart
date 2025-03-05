class Exercise {
  static String mName = "exercise";

  late String id;
  late String name;
  late int sets;
  late int repetitions;

  Exercise(this.name, this.sets, this.repetitions);

  Exercise.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    name = map["name"];
    sets = map["sets"];
    repetitions = map["repetitions"];
  }

  static List<Exercise>? getExercisesList(List? exerciseMap) {
    if (exerciseMap != null) {
      List<Exercise> exercisesList = exerciseMap.map((e) {
        return Exercise.fromMap(e);
      }).toList();

      return exercisesList;
    }
    return null;
  }

  @override
  String toString() {
    return "Exercise name is: $name, with $sets of $repetitions times.";
  }
}
