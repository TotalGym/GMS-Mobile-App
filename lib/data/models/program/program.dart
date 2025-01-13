import 'package:gmn/data/models/program/exercise.dart';
import 'package:gmn/data/models/trainee/trainee.dart';

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
    id = map["id"];
    exercises = Exercise.getExercisesList(map["exercises"]);
    description = map["description"];
    image = map["image"];
    schedual = map["schedule"];
    registeredTrainees = map["registeredTrainees"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "exercises": exercises,
      "description": description,
      "image": image,
      "schedule": schedual,
      "registeredTrainees": registeredTrainees,
    };
  }

  @override
  String toString() {
    return "Program description: $description, of ${{
      exercises ?? []
    }.length} exercises ";
  }
}
