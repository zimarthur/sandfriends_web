import 'Hour.dart';
import 'AppMatch.dart';

class DayMatch {
  Hour startingHour;
  AppMatch? match;

  DayMatch({
    required this.startingHour,
    this.match,
  });
}
