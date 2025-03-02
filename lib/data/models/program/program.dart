import 'package:gmn/data/models/program/exercise.dart';

class Program {
  static String mName = "programs";

  String? id;
  List<Exercise>? exercises = [];
  String? description;
  num? monthlyPrice;
  num? annualPrice;
  String? image;
  List? schedual = [];

  Program(
    this.id,
    this.schedual, {
    this.exercises,
    this.description = 'No Description',
    this.image = 'No source available',
  });

  Program.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    exercises = Exercise.getExercisesList(map["exercises"]);
    description = map["description"];
    monthlyPrice = map["monthlyPrice"];
    annualPrice = map["annuallyPrice"];
    image = map["image"];
    schedual = map["schedule"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "exercises": exercises,
      "description": description,
      "image": image,
      "schedule": schedual,
    };
  }

  @override
  String toString() {
    return "Program description: $description, of ${{
      exercises ?? []
    }.length} exercises ";
  }
}
