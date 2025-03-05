import 'dart:developer';
import 'package:gmn/data/models/user/trainee/trainee.dart';
import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class TraineeRepo extends Repo<Trainee> {
  TraineeRepo.fromMap(Map map) {
    super.fromMap(map);
  }

  @override
  void update(Repo tempRepo) {
    super.update(tempRepo);
  }

  static Future<TraineeRepo> getTrainees(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce =
        await DioHelper.io.get(token, Trainee.mName, "", queryParameter);
    Map data = responce["data"];

    List<Trainee> trainees = loadTrainees(data);

    Map traineeRepoMap = {
      'totalCount': data['totalCount'],
      'page': data['page'],
      'limit': data['limit'],
      'next': data['next'],
      'items': trainees,
    };

    TraineeRepo traineeRepo = TraineeRepo.fromMap(traineeRepoMap);

    return traineeRepo;
  }

  static Future<Trainee> getTrainee(
      String token, Map<String, dynamic> queryParameter) async {
    Map data =
        await DioHelper.io.get(token, Trainee.profile, '', queryParameter);

    log("trainee_repo-> return value is: $data");

    Trainee trainee = Trainee.fromMap(data['data']);

    return trainee;
  }

  static List<Trainee> loadTrainees(Map data) {
    List traineesMapList = data['results'];

    List<Trainee> trainees = traineesMapList.map((e) {
      return Trainee.fromMap(e);
    }).toList();

    return trainees;
  }
}
