import 'package:gmn/models/exercise.dart';
import 'package:gmn/models/schedual_instance.dart';
import 'package:gmn/models/trainee.dart';

class Program {
  String id;
  List<Exercise>? exercises = [];
  String description;
  String image;
  List<SchedualInstance> schedual = [];
  List<Trainee>? registeredTrainees = [];

  Program(this.id, this.schedual,
      {this.exercises,
      this.description = 'No Description',
      this.image = 'No source available',
      this.registeredTrainees});

  @override
  String toString() {
    return "Program description: $description, of ${{
      exercises ?? []
    }.length} exercises ";
  }
}
