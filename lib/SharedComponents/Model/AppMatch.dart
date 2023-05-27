import 'Hour.dart';
import 'Sport.dart';
import 'package:intl/intl.dart';

class AppMatch {
  int idMatch;
  int? idRecurrentMatch;
  DateTime date;
  int cost;
  DateTime creationDate;
  String creatorNotes;
  int idStoreCourt;
  Sport sport;
  Hour startingHour;
  Hour endingHour;
  String matchCreator;

  int get matchDuration {
    return endingHour.hour - startingHour.hour;
  }

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
    required this.matchCreator,
  });

  factory AppMatch.fromJson(Map<String, dynamic> parsedJson,
      List<Hour> referenceHours, List<Sport> referenceSports) {
    return AppMatch(
      idMatch: parsedJson["IdMatch"],
      creationDate: DateFormat("dd/MM/yyyy").parse(
        parsedJson["Date"],
      ),
      date: DateFormat("dd/MM/yyyy").parse(
        parsedJson["Date"],
      ),
      startingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeBegin"]),
      endingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeEnd"]),
      idStoreCourt: parsedJson["IdStoreCourt"],
      cost: parsedJson["Cost"],
      sport: referenceSports
          .firstWhere((sport) => sport.idSport == parsedJson["IdSport"]),
      creatorNotes: parsedJson["CreatorNotes"],
      matchCreator: parsedJson["MatchCreator"],
      idRecurrentMatch: parsedJson["IdRecurrentMatch"],
    );
  }
}
