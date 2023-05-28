import 'package:sandfriends_web/Features/Calendar/Model/DayMatch.dart';

class CalendarWeeklyDayMatch {
  DateTime date;
  List<DayMatch> dayMatches;

  CalendarWeeklyDayMatch({
    required this.date,
    required this.dayMatches,
  });
}
