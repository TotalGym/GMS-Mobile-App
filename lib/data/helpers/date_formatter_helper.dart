class DateFormatterHelper {
  static String dateFromString(String date) {
    late DateTime localDate;
    late String day;
    late String month;
    late String year;
    late String formattedDate;
    try {
      localDate = DateTime.parse(date).toLocal();
      day = localDate.day.toString();
      month = _getMonthName(localDate.month);
      year = localDate.year.toString();
      formattedDate = "$day${_getDaySuffix(localDate.day)} $month $year";
    } catch (e) {
      formattedDate = "Invalid Date";
    }
    return formattedDate;
  }

  static String dayFromDateTime(DateTime date) {
    String dayOfWeek = date.weekday.toString();
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String formattedDate =
        "${_getDayOfWeekAbbreviation(dayOfWeek)} $day-$month";
    return formattedDate;
  }

  static String _getDayOfWeekAbbreviation(String dayOfWeek) {
    const List<String> days = [
      'MON.',
      'TUES.',
      'WED.',
      'THUR.',
      'FRI.',
      'SAT.',
      'SUN.'
    ];
    return days[int.parse(dayOfWeek) - 1];
  }

  static String timeFromString(String time) {
    late String hour;
    late String minute;
    late String formattedTime;
    try {
      DateTime localTime = DateTime.parse("1970-01-01T$time:00Z").toLocal();
      hour = localTime.hour.toString();
      minute = localTime.minute.toString();
      bool isPM = int.parse(hour) >= 12;
      String period = isPM ? "PM" : "AM";
      int hourInt = int.parse(time.split(":")[0]) % 12;
      hourInt = hourInt == 0 ? 12 : hourInt; // handle midnight and noon
      hour = hourInt.toString();
      formattedTime = "$hour:$minute $period";
    } catch (e) {
      formattedTime = time;
    }

    return formattedTime;
  }

  static String timeFromDateTime(DateTime dateTime) {
    late String hour;
    late String minute;
    late String formattedTime;
    try {
      DateTime localTime = dateTime.toLocal();
      hour = localTime.hour.toString().padLeft(2, '0');
      minute = localTime.minute.toString().padLeft(2, '0');
      bool isPM = localTime.hour >= 12;
      String period = isPM ? "PM" : "AM";
      int hourInt = localTime.hour % 12;
      hourInt = hourInt == 0 ? 12 : hourInt; // handle midnight and noon
      hour = hourInt.toString();
      formattedTime = "$hour:$minute $period";
    } catch (e) {
      formattedTime = "Invalid Time";
    }

    return formattedTime;
  }

  static String _getMonthName(int month) {
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
