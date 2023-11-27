import 'package:sandfriends_web/SharedComponents/Model/AppMatch.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppRecurrentMatch.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';

import '../../../SharedComponents/Model/Court.dart';
import '../../../SharedComponents/Model/Sport.dart';

class HourInformation {
  bool match;
  bool recurrentMatch;
  bool freeHour;
  String creatorName;
  Sport? sport;
  double? cost;
  bool? payInStore;
  Hour timeBegin;
  Hour timeEnd;
  Court court;
  int selectedRow;
  int selectedColumn;

  AppMatch? refMatch;
  AppRecurrentMatch? refRecurrentMatch;

  HourInformation({
    this.match = false,
    this.recurrentMatch = false,
    this.freeHour = false,
    required this.creatorName,
    this.sport,
    this.payInStore,
    this.cost,
    required this.court,
    required this.timeBegin,
    required this.timeEnd,
    required this.selectedColumn,
    required this.selectedRow,
    this.refMatch,
    this.refRecurrentMatch,
  });
}
