import 'Hour.dart';

class StoreWorkingDay {
  int weekday;
  Hour? startingHour;
  Hour? endingHour;
  bool isEnabled;

  StoreWorkingDay({
    required this.weekday,
    required this.isEnabled,
    this.startingHour,
    this.endingHour,
  });

  factory StoreWorkingDay.copyFrom(StoreWorkingDay refWorkingHours) {
    return StoreWorkingDay(
      weekday: refWorkingHours.weekday,
      isEnabled: refWorkingHours.isEnabled,
      startingHour: refWorkingHours.startingHour,
      endingHour: refWorkingHours.endingHour,
    );
  }
}
