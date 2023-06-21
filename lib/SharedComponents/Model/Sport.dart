import 'package:sandfriends_web/Remote/Url.dart';

class Sport {
  int idSport;
  String description;
  String sportPhoto;

  Sport({
    required this.idSport,
    required this.description,
    required this.sportPhoto,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Sport == false) return false;
    Sport otherSport = other as Sport;

    return idSport == otherSport.idSport;
  }

  @override
  int get hashCode => idSport.hashCode ^ description.hashCode;

  factory Sport.fromJson(Map<String, dynamic> parsedJson) {
    return Sport(
      idSport: parsedJson["IdSport"],
      description: parsedJson["Description"],
      sportPhoto: sandfriendsRequestsUrl + parsedJson["SportPhoto"],
    );
  }
}
