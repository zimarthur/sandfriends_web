import '../../../SharedComponents/Model/AppMatch.dart';
import '../../../SharedComponents/Model/Hour.dart';

class DayMatch {
  Hour startingHour;
  AppMatch? match;
  List<AppMatch>? matches;

  DayMatch({
    required this.startingHour,
    this.match,
    this.matches,
  });

  factory DayMatch.copyWith(DayMatch refDayMatch) {
    return DayMatch(
      startingHour: refDayMatch.startingHour,
      match: refDayMatch.match,
      matches: refDayMatch.matches,
    );
  }
}
