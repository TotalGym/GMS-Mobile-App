class DateFormatterHelper {
  late DateTime localDate;
  late String day;
  late String month;
  late String year;
  late String formattedDate;

  DateFormatterHelper.fromString(String date) {
    try {
      localDate = DateTime.parse(date).toLocal();
      day = localDate.day.toString();
      month = _getMonthName(localDate.month);
      year = localDate.year.toString();
      formattedDate = "$day${_getDaySuffix(localDate.day)} $month $year";
    } catch (e) {
      formattedDate = "Invalid Date";
    }
  }

  @override
  String toString() {
    return formattedDate;
  }

  String _getMonthName(int month) {
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

  String _getDaySuffix(int day) {
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
