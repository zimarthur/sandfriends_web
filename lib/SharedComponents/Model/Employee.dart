import 'package:intl/intl.dart';

class Employee {
  String firstName;
  String lastName;
  String email;
  bool admin;
  DateTime registrationDate;
  bool isLoggedUser;
  bool isCourtOwner;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.admin,
    required this.registrationDate,
    this.isLoggedUser = false,
    this.isCourtOwner = false,
  });

  factory Employee.fromJson(Map<String, dynamic> parsedJson) {
    return Employee(
      firstName: parsedJson["FirstName"],
      lastName: parsedJson["LastName"],
      email: parsedJson["Email"],
      admin: parsedJson["Admin"],
      registrationDate:
          DateFormat("dd/MM/yyyy").parse(parsedJson["RegistrationDate"]),
      isLoggedUser: false,
    );
  }
}
