import 'package:sandfriends_web/SharedComponents/Model/AppMatch.dart';
import 'package:intl/intl.dart';

import 'Hour.dart';
import 'Sport.dart';

class AppNotification {
  String message;
  AppMatch match;
  DateTime eventTime;

  AppNotification({
    required this.message,
    required this.match,
    required this.eventTime,
  });

  factory AppNotification.fromJson(
    Map<String, dynamic> parsedJson,
    List<Hour> referenceHours,
    List<Sport> referenceSports,
  ) {
    return AppNotification(
      message: parsedJson["Message"],
      eventTime: DateFormat("dd/MM/yyyy HH:mm").parse(
        parsedJson["EventDatetime"],
      ),
      match: AppMatch.fromJson(
          parsedJson["Match"], referenceHours, referenceSports),
    );
  }
}
