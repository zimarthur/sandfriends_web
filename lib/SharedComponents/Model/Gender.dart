import 'package:sandfriends_web/Remote/Url.dart';

class Gender {
  int idGender;
  String genderName;

  Gender({
    required this.idGender,
    required this.genderName,
  });

  factory Gender.fromJson(Map<String, dynamic> parsedJson) {
    return Gender(
      idGender: parsedJson["IdGenderCategory"],
      genderName: parsedJson["GenderName"],
    );
  }
}
