import 'Hour.dart';
import 'Sport.dart';
import 'package:intl/intl.dart';

class AppMatch {
  int idMatch;
  int idRecurrentMatch;
  DateTime date;
  int cost;
  DateTime creationDate;
  String creatorNotes;
  int idStoreCourt;
  Sport? sport;
  Hour startingHour;
  Hour endingHour;
  String matchCreatorFirstName;
  String matchCreatorLastName;
  String? matchCreatorPhoto;
  bool blocked;
  String blockedReason;

  int get matchDuration {
    return endingHour.hour - startingHour.hour;
  }

  String get matchCreatorName =>
      "${matchCreatorFirstName} ${matchCreatorLastName}";

  AppMatch({
    required this.idMatch,
    required this.date,
    required this.cost,
    required this.creationDate,
    required this.creatorNotes,
    required this.idRecurrentMatch,
    required this.idStoreCourt,
    required this.sport,
    required this.startingHour,
    required this.endingHour,
    required this.matchCreatorFirstName,
    required this.matchCreatorLastName,
    required this.matchCreatorPhoto,
    required this.blocked,
    required this.blockedReason,
  });

  factory AppMatch.fromJson(Map<String, dynamic> parsedJson,
      List<Hour> referenceHours, List<Sport> referenceSports) {
    Hour timeBegin = referenceHours.firstWhere(
      (hour) => hour.hour == parsedJson['TimeBegin'],
    );
    return AppMatch(
      idMatch: parsedJson["IdMatch"],
      creationDate: DateFormat("dd/MM/yyyy").parse(
        parsedJson["Date"],
      ),
      date: DateFormat("dd/MM/yyyy HH:mm").parse(
        "${parsedJson["Date"]} ${timeBegin.hourString}",
      ),
      startingHour: timeBegin,
      endingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeEnd"]),
      idStoreCourt: parsedJson["IdStoreCourt"],
      cost: parsedJson["Cost"],
      sport: parsedJson["IdSport"] == null
          ? null
          : referenceSports
              .firstWhere((sport) => sport.idSport == parsedJson["IdSport"]),
      creatorNotes: parsedJson["CreatorNotes"],
      matchCreatorFirstName: parsedJson["MatchCreatorFirstName"],
      matchCreatorLastName: parsedJson["MatchCreatorLastName"],
      matchCreatorPhoto: parsedJson["MatchCreatorPhoto"],
      idRecurrentMatch: parsedJson["IdRecurrentMatch"],
      blocked: parsedJson["Blocked"] ?? false,
      blockedReason: parsedJson["BlockedReason"] ?? "",
    );
  }

  factory AppMatch.copyWith(AppMatch refMatch) {
    return AppMatch(
      idMatch: refMatch.idMatch,
      date: refMatch.date,
      cost: refMatch.cost,
      creationDate: refMatch.creationDate,
      creatorNotes: refMatch.creatorNotes,
      idRecurrentMatch: refMatch.idRecurrentMatch,
      idStoreCourt: refMatch.idStoreCourt,
      sport: refMatch.sport,
      startingHour: refMatch.startingHour,
      endingHour: refMatch.endingHour,
      matchCreatorFirstName: refMatch.matchCreatorFirstName,
      matchCreatorLastName: refMatch.matchCreatorLastName,
      matchCreatorPhoto: refMatch.matchCreatorPhoto,
      blocked: refMatch.blocked,
      blockedReason: refMatch.blockedReason,
    );
  }
}
