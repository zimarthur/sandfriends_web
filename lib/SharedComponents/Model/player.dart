import '../../Remote/Url.dart';

class Player {
  int idUser;
  String firstName;
  String lastName;
  String? photo;

  Player({
    required this.idUser,
    required this.firstName,
    required this.lastName,
    required this.photo,
  });

  factory Player.fromJson(Map<String, dynamic> parsedJson) {
    return Player(
      idUser: parsedJson["IdUser"],
      firstName: parsedJson["FirstName"],
      lastName: parsedJson["LastName"],
      photo: parsedJson["Photo"],
    );
  }
}
