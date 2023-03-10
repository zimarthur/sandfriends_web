import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';

import 'Sport.dart';

class Court {
  int idStoreCourt;
  String description;
  bool isIndoor;

  List<Sport> sports = [];
  List<HourPrice> prices = [];

  Court({
    required this.idStoreCourt,
    required this.description,
    required this.isIndoor,
  });

  factory Court.fromJson(Map<String, dynamic> parsedJson) {
    final newCourt = Court(
      idStoreCourt: parsedJson["IdStoreCourt"],
      description: parsedJson["Description"],
      isIndoor: parsedJson["IsIndoor"],
    );

    for (int i = 0; i < parsedJson["Sports"].length; i++) {
      newCourt.sports.add(Sport.fromJson(parsedJson["Sports"][i]));
    }

    for (int i = 0; i < parsedJson["Prices"].length; i++) {
      newCourt.prices.add(HourPrice.fromJson(parsedJson["Prices"][i]));
    }

    return newCourt;
  }
}
