class ApiHelper {
  static String baseAPI = "https://gym-api-byh1.onrender.com/api";
  static String link({String modelName = ""}) {
    return "${baseAPI}$modelName/";
  }
}
