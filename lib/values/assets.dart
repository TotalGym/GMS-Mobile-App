class Assets {
  static String emptyNotifications = 'empty_notifications.json';
  static String loadingNotifications = 'loading_notification.json';
  static String emptyBox = 'empty_box.json';
  static String loading = 'loading.json';
  static String login = 'login.json';
  static String dumbbells = 'dumbbells.json';
  static String bellNotification = 'bell_notification.json';

  static String getImage(String imageNameWithExtention) {
    return 'assets/images/$imageNameWithExtention';
  }

  static String getIcon(String iconNameWithExtention) {
    return 'assets/icons/$iconNameWithExtention';
  }

  static String getAnimation(String animationNameWithExtention) {
    return 'assets/animations/$animationNameWithExtention';
  }
}
