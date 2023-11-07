import 'package:sandfriends_web/SharedComponents/Model/Gender.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';

import '../../Remote/Url.dart';

class Rank {
  int idRankCategory;
  int idSport;
  int rankSportLevel;
  String rankName;
  String rankColor;

  Rank({
    required this.idRankCategory,
    required this.idSport,
    required this.rankSportLevel,
    required this.rankName,
    required this.rankColor,
  });

  factory Rank.fromJson(Map<String, dynamic> parsedJson) {
    return Rank(
      idRankCategory: parsedJson["IdRankCategory"],
      idSport: parsedJson["IdSport"],
      rankSportLevel: parsedJson["RankSportLevel"],
      rankName: parsedJson["RankName"],
      rankColor: parsedJson["RankColor"],
    );
  }
}
