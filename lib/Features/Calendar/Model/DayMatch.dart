import 'package:sandfriends_web/SharedComponents/Model/AppRecurrentMatch.dart';

import '../../../SharedComponents/Model/AppMatch.dart';
import '../../../SharedComponents/Model/Hour.dart';

class DayMatch {
  Hour startingHour;
  AppMatch? match;
  List<AppMatch>? matches;
  AppRecurrentMatch? recurrentMatch;
  List<AppRecurrentMatch>? recurrentMatches;
  bool operationHour;

  DayMatch({
    required this.startingHour,
    this.match,
    this.matches,
    this.recurrentMatch,
    this.recurrentMatches,
    this.operationHour = false,
  });

  factory DayMatch.copyWith(DayMatch refDayMatch) {
    return DayMatch(
      startingHour: refDayMatch.startingHour,
      match: refDayMatch.match,
      matches: refDayMatch.matches,
      recurrentMatch: refDayMatch.recurrentMatch,
      recurrentMatches: refDayMatch.recurrentMatches,
      operationHour: refDayMatch.operationHour,
    );
  }
}
