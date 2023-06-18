import 'AppMatch.dart';
import 'Hour.dart';
import 'Sport.dart';
import 'package:intl/intl.dart';

class AppRecurrentMatch {
  int idRecurrentMatch;
  DateTime creationDate;
  DateTime lastPaymentDate;
  int weekday;
  Hour startingHour;
  Hour endingHour;
  int idStoreCourt;
  String creatorFirstName;
  String creatorLastName;
  String? creatorPhoto;
  Sport? sport;
  int matchCounter;
  bool canceled;
  bool blocked;
  String blockedReason;
  List<AppMatch> currentMonthMatches;

  int get recurrentMatchDuration {
    return endingHour.hour - startingHour.hour;
  }

  int get currentMonthPrice => currentMonthMatches.fold(
      0, (previousValue, element) => previousValue + element.cost);

  String get creatorName => "$creatorFirstName $creatorLastName";

  AppRecurrentMatch({
    required this.idRecurrentMatch,
    required this.creationDate,
    required this.lastPaymentDate,
    required this.weekday,
    required this.startingHour,
    required this.endingHour,
    required this.idStoreCourt,
    required this.creatorFirstName,
    required this.creatorLastName,
    required this.creatorPhoto,
    required this.sport,
    required this.matchCounter,
    required this.canceled,
    required this.blocked,
    required this.blockedReason,
    required this.currentMonthMatches,
  });

  factory AppRecurrentMatch.fromJson(Map<String, dynamic> parsedJson,
      List<Hour> referenceHours, List<Sport> referenceSports) {
    List<AppMatch> currentMonthMatches = [];
    for (var match in parsedJson["CurrentMonthMatches"]) {
      currentMonthMatches.add(
        AppMatch.fromJson(
          match,
          referenceHours,
          referenceSports,
        ),
      );
    }
    return AppRecurrentMatch(
      idRecurrentMatch: parsedJson["IdRecurrentMatch"],
      creationDate: DateFormat("dd/MM/yyyy").parse(
        parsedJson["CreationDate"],
      ),
      lastPaymentDate: DateFormat("dd/MM/yyyy").parse(
        parsedJson["LastPaymentDate"],
      ),
      weekday: parsedJson["Weekday"],
      startingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeBegin"]),
      endingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeEnd"]),
      idStoreCourt: parsedJson["IdStoreCourt"],
      sport: parsedJson["IdSport"] == null
          ? null
          : referenceSports
              .firstWhere((sport) => sport.idSport == parsedJson["IdSport"]),
      creatorFirstName: parsedJson["UserFirstName"] ?? "",
      creatorLastName: parsedJson["UserLastName"] ?? "",
      creatorPhoto: parsedJson["UserPhoto"] ?? "",
      matchCounter: parsedJson["RecurrentMatchCounter"],
      canceled: parsedJson["Canceled"] ?? false,
      blocked: parsedJson["Blocked"] ?? false,
      blockedReason: parsedJson["BlockedReason"] ?? "",
      currentMonthMatches: currentMonthMatches,
    );
  }

  factory AppRecurrentMatch.copyWith(AppRecurrentMatch refMatch) {
    return AppRecurrentMatch(
      idRecurrentMatch: refMatch.idRecurrentMatch,
      creationDate: refMatch.creationDate,
      lastPaymentDate: refMatch.lastPaymentDate,
      weekday: refMatch.weekday,
      startingHour: refMatch.startingHour,
      endingHour: refMatch.endingHour,
      idStoreCourt: refMatch.idStoreCourt,
      sport: refMatch.sport,
      creatorFirstName: refMatch.creatorFirstName,
      creatorLastName: refMatch.creatorLastName,
      creatorPhoto: refMatch.creatorPhoto,
      matchCounter: refMatch.matchCounter,
      canceled: refMatch.canceled,
      blocked: refMatch.blocked,
      blockedReason: refMatch.blockedReason,
      currentMonthMatches: refMatch.currentMonthMatches
          .map((match) => AppMatch.copyWith(match))
          .toList(),
    );
  }
}
