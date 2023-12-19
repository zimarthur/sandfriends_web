import 'AppMatch.dart';
import 'Court.dart';
import 'Hour.dart';
import 'Sport.dart';
import 'package:intl/intl.dart';

class AppRecurrentMatch {
  int idRecurrentMatch;
  DateTime creationDate;
  DateTime lastPaymentDate;
  DateTime? validUntil;
  int weekday;
  Hour startingHour;
  Hour endingHour;
  Court court;
  String creatorFirstName;
  String creatorLastName;
  String? creatorPhoto;
  Sport? sport;
  int matchCounter;
  bool canceled;
  bool blocked;
  String blockedReason;
  List<AppMatch> nextRecurrentMatches;

  int get recurrentMatchDuration {
    return endingHour.hour - startingHour.hour;
  }

  double get currentMonthPrice => nextRecurrentMatches.fold(
      0, (previousValue, element) => previousValue + element.cost);

  double get matchCost => currentMonthPrice / nextRecurrentMatches.length;

  String get creatorName => "$creatorFirstName $creatorLastName";

  String get matchHourDescription =>
      "${startingHour.hourString} - ${endingHour.hourString}";

  bool get payInStore => blocked ? true : nextRecurrentMatches.first.payInStore;

  AppRecurrentMatch({
    required this.idRecurrentMatch,
    required this.creationDate,
    required this.lastPaymentDate,
    required this.validUntil,
    required this.weekday,
    required this.startingHour,
    required this.endingHour,
    required this.court,
    required this.creatorFirstName,
    required this.creatorLastName,
    required this.creatorPhoto,
    required this.sport,
    required this.matchCounter,
    required this.canceled,
    required this.blocked,
    required this.blockedReason,
    required this.nextRecurrentMatches,
  });

  factory AppRecurrentMatch.fromJson(
    Map<String, dynamic> parsedJson,
    List<Hour> referenceHours,
    List<Sport> referenceSports,
  ) {
    List<AppMatch> nextRecurrentMatches = [];
    for (var match in parsedJson["NextRecurrentMatches"]) {
      nextRecurrentMatches.add(
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
      validUntil: parsedJson["ValidUntil"] != null
          ? DateFormat("dd/MM/yyyy").parse(
              parsedJson["ValidUntil"],
            )
          : null,
      weekday: parsedJson["Weekday"],
      startingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeBegin"]),
      endingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeEnd"]),
      court: Court.fromJsonMatch(parsedJson["StoreCourt"]),
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
      nextRecurrentMatches: nextRecurrentMatches,
    );
  }

  factory AppRecurrentMatch.copyWith(AppRecurrentMatch refMatch) {
    return AppRecurrentMatch(
      idRecurrentMatch: refMatch.idRecurrentMatch,
      creationDate: refMatch.creationDate,
      lastPaymentDate: refMatch.lastPaymentDate,
      validUntil: refMatch.validUntil,
      weekday: refMatch.weekday,
      startingHour: refMatch.startingHour,
      endingHour: refMatch.endingHour,
      court: refMatch.court,
      sport: refMatch.sport,
      creatorFirstName: refMatch.creatorFirstName,
      creatorLastName: refMatch.creatorLastName,
      creatorPhoto: refMatch.creatorPhoto,
      matchCounter: refMatch.matchCounter,
      canceled: refMatch.canceled,
      blocked: refMatch.blocked,
      blockedReason: refMatch.blockedReason,
      nextRecurrentMatches: refMatch.nextRecurrentMatches
          .map((match) => AppMatch.copyWith(match))
          .toList(),
    );
  }
}
