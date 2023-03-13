import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';

class OperationDay {
  bool isEnabled;
  int weekDay;
  Hour startingHour;
  Hour endingHour;

  OperationDay({
    this.isEnabled = true,
    required this.weekDay,
    required this.startingHour,
    required this.endingHour,
  });
}
