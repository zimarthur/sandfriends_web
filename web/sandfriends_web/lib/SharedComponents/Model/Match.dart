import 'Hour.dart';
import 'Sport.dart';

class Match {
  int idMatch;
  DateTime date;
  int cost;
  bool openUsers;
  int maxUsers;
  bool canceled;
  DateTime creationDate;
  String matchUrl;
  String creatorNotes;
  int? idRecurrentMatch;
  int idStoreCOurt;
  Sport sport;
  Hour startingHour;
  Hour endingHour;
  List<int> membersUserIds;

  Match({
    required this.idMatch,
    required this.date,
    required this.cost,
    required this.openUsers,
    required this.maxUsers,
    required this.canceled,
    required this.creationDate,
    required this.matchUrl,
    required this.creatorNotes,
    required this.idRecurrentMatch,
    required this.idStoreCOurt,
    required this.sport,
    required this.startingHour,
    required this.endingHour,
    required this.membersUserIds,
  });
}
