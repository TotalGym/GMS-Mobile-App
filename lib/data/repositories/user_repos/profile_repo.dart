import 'dart:developer';
import 'package:gmn/data/models/user/profile/profile.dart';
import 'package:gmn/data/helpers/dio_helper.dart';
import 'package:gmn/data/repositories/repo.dart';

class ProfileRepo extends Repo<Profile> {
  ProfileRepo.fromMap(Map map) {
    super.fromMap(map);
  }

  @override
  void update(Repo tempRepo) {
    super.update(tempRepo);
  }

  static Future<ProfileRepo> getProfiles(
      String token, Map<String, dynamic> queryParameter) async {
    Map responce =
        await DioHelper.io.get(token, Profile.trainee, "", queryParameter);
    Map data = responce["data"];

    List<Profile> trainees = loadProfiles(data);

    Map traineeRepoMap = {
      'totalCount': data['totalCount'],
      'page': data['page'],
      'limit': data['limit'],
      'next': data['next'],
      'items': trainees,
    };

    ProfileRepo traineeRepo = ProfileRepo.fromMap(traineeRepoMap);

    return traineeRepo;
  }

  static Future<Profile> getProfile(
      String token, Map<String, dynamic> queryParameter) async {
    Map data =
        await DioHelper.io.get(token, Profile.profile, '', queryParameter);

    log("profile_repo -> return value is: $data");

    Profile trainee = Profile.fromMap(data['data']);

    return trainee;
  }

  static List<Profile> loadProfiles(Map data) {
    List traineesMapList = data['results'];

    List<Profile> trainees = traineesMapList.map((e) {
      return Profile.fromMap(e);
    }).toList();

    return trainees;
  }
}
