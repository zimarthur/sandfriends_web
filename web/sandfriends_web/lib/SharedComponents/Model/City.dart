import 'package:sandfriends_web/SharedComponents/Model/State.dart';

class City {
  int idCity;
  String name;
  State state;

  City({
    required this.idCity,
    required this.name,
    required this.state,
  });

  factory City.fromJson(Map<String, dynamic> parsedJson) {
    return City(
      idCity: parsedJson["IdCity"],
      name: parsedJson["City"],
      state: State.fromJson(parsedJson["State"]),
    );
  }
}
