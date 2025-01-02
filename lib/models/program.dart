import 'package:gmn/models/exercise.dart';
import 'package:gmn/models/trainee/trainee.dart';

class Program {
  late String id;
  late List<Exercise>? exercises = [];
  late String description;
  late String image;
  late List<Map<String, dynamic>> schedual = [];
  late List<Trainee>? registeredTrainees = [];

  Program(this.id, this.schedual,
      {this.exercises,
      this.description = 'No Description',
      this.image = 'No source available',
      this.registeredTrainees});

  Program.fromMap(Map<String, dynamic> map) {
    id = map["ID"];
    exercises = Exercise.getExercisesList(map["Exercises"]);
    description = map["Description"];
    image = map["Image"];
    schedual = map["Schedule"];
    registeredTrainees = map["RegisteredTrainees"];
  }

  @override
  String toString() {
    return "Program description: $description, of ${{
      exercises ?? []
    }.length} exercises ";
  }
}
