import 'package:flutter/widgets.dart';
import 'package:gmn/data/models/program/program.dart';
import 'package:gmn/data/repositories/program_repo.dart';

class ProgramProvider extends ChangeNotifier {
  List<Program>? programs;

  getAllPrograms() async {
    programs = await ProgramRepo().getAllPrograms();
    notifyListeners();
  }
}
