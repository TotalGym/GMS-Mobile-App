import 'package:gmn/data/models/content/program/exercise.dart';
import 'package:gmn/data/models/content/program_store_interface.dart';

class Program implements ProgramStore {
  static String mName = "programs";

  String? id;
  String? name;
  List<Exercise>? exercises = [];
  String? description;
  num? monthlyPrice;
  num? annualPrice;
  String? image;
  List? schedual = [];
  List? registeredTrainees = [];

  Program.fromMap(Map<String, dynamic> map) {
    id = map["_id"];
    name = map["programName"];
    exercises = Exercise.getExercisesList(map["exercises"] ?? []);
    description = map["description"];
    monthlyPrice = map["monthlyPrice"];
    annualPrice = map["annuallyPrice"];
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
    };
  }

  @override
  String toString() {
    return "Program: $name, description: $description, of ${{
      exercises ?? []
    }.length} exercises ";
  }
}
