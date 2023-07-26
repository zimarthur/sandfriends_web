import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/PriceRule.dart';

class Court {
  int? idStoreCourt;
  String description;
  bool isIndoor;

  List<AvailableSport> sports = [];
  List<OperationDay> operationDays = [];

  Court({
    this.idStoreCourt,
    required this.description,
    required this.isIndoor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Court == false) return false;
    Court otherCourt = other as Court;
    for (var avSport in sports) {
      if (avSport !=
          otherCourt.sports
              .firstWhere((sport) => sport.sport == avSport.sport)) {
        return false;
      }
    }
    //caso tenha adicionado um novo dia no jhorario de funcionamento, os horarios existentes podiam ser os mesmos, mas o len deles não
    if (operationDays.length != other.operationDays.length) {
      return false;
    }
    for (var operationDay in operationDays) {
      if (operationDay !=
          other.operationDays
              .firstWhere((opDay) => opDay.weekday == operationDay.weekday)) {
        return false;
      }
    }
    return description == otherCourt.description &&
        isIndoor == otherCourt.isIndoor;
  }

  factory Court.fromJson(Map<String, dynamic> parsedJson) {
    final newCourt = Court(
      idStoreCourt: parsedJson["IdStoreCourt"],
      description: parsedJson["Description"],
      isIndoor: parsedJson["IsIndoor"],
    );
    for (int weekday = 0; weekday < 7; weekday++) {
      newCourt.operationDays.add(
        OperationDay(
          weekday: weekday,
        ),
      );
    }
    return newCourt;
  }

  factory Court.fromJsonMatch(Map<String, dynamic> parsedJson) {
    return Court(
      idStoreCourt: parsedJson["IdStoreCourt"],
      description: parsedJson["Description"],
      isIndoor: parsedJson["IsIndoor"],
    );
  }

  factory Court.copyFrom(Court refCourt) {
    final court = Court(
      description: refCourt.description,
      isIndoor: refCourt.isIndoor,
      idStoreCourt: refCourt.idStoreCourt,
    );
    for (var opDay in refCourt.operationDays) {
      court.operationDays.add(
        OperationDay.copyFrom(
          opDay,
        ),
      );
    }
    for (var sport in refCourt.sports) {
      court.sports.add(
        AvailableSport.copyFrom(
          sport,
        ),
      );
    }
    return court;
  }

  @override
  int get hashCode => idStoreCourt.hashCode ^ description.hashCode;
}
