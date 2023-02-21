import 'package:intl/intl.dart';

DateTime lastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}

bool isSameDate(DateTime a, DateTime b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

bool isInCurrentMonth(DateTime a) {
  return a.month == DateTime.now().month && a.year == DateTime.now().year;
}
