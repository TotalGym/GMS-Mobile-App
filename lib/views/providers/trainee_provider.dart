import 'package:flutter/widgets.dart';
import 'package:gmn/data/models/trainee/trainee.dart';
// import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/data/repositories/trainee_repo.dart';

class TraineeProvider extends ChangeNotifier {
  late Trainee trainees = Trainee([]);

  // late String response = "nothing yet";
  getTrainee() async {
    trainees = await TraineeRepo().getTrainee();
    notifyListeners();
  }

  getUser() async {}

  // getAnyResponse() async {
  //   response = await TraineeRepo().getAnyResponse();
  //   print(
  //       "response is: ${response.toString()} inside the proivders's get any responde");
  //   // notifyListeners();
  // }
}
