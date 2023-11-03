import 'package:sandfriends_web/SharedComponents/Model/Court.dart';

import 'Hour.dart';
import 'PaymentStatus.dart';
import 'SelectedPayment.dart';
import 'Sport.dart';
import 'package:intl/intl.dart';

class AppMatch {
  int idMatch;
  int idRecurrentMatch;
  DateTime date;
  double cost;
  DateTime creationDate;
  String creatorNotes;
  Court court;
  Sport? sport;
  Hour startingHour;
  Hour endingHour;
  String matchCreatorFirstName;
  String matchCreatorLastName;
  String? matchCreatorPhoto;
  bool blocked;
  String blockedReason;
  SelectedPayment selectedPayment;
  PaymentStatus paymentStatus;
  DateTime paymentExpirationDate;
  double netCost;

  int get matchDuration {
    return endingHour.hour - startingHour.hour;
  }

  String get matchCreatorName =>
      "${matchCreatorFirstName} ${matchCreatorLastName}";

  AppMatch({
    required this.idMatch,
    required this.date,
    required this.cost,
    required this.creationDate,
    required this.creatorNotes,
    required this.idRecurrentMatch,
    required this.court,
    required this.sport,
    required this.startingHour,
    required this.endingHour,
    required this.matchCreatorFirstName,
    required this.matchCreatorLastName,
    required this.matchCreatorPhoto,
    required this.blocked,
    required this.blockedReason,
    required this.paymentStatus,
    required this.selectedPayment,
    required this.paymentExpirationDate,
    required this.netCost,
  });

  factory AppMatch.fromJson(Map<String, dynamic> parsedJson,
      List<Hour> referenceHours, List<Sport> referenceSports) {
    Hour timeBegin = referenceHours.firstWhere(
      (hour) => hour.hour == parsedJson['TimeBegin'],
    );
    return AppMatch(
      idMatch: parsedJson["IdMatch"],
      creationDate: DateFormat("dd/MM/yyyy").parse(
        parsedJson["Date"],
      ),
      date: DateFormat("dd/MM/yyyy HH:mm").parse(
        "${parsedJson["Date"]} ${timeBegin.hourString}",
      ),
      startingHour: timeBegin,
      endingHour: referenceHours
          .firstWhere((hour) => hour.hour == parsedJson["TimeEnd"]),
      court: Court.fromJsonMatch(parsedJson["StoreCourt"]),
      cost: parsedJson["Cost"],
      sport: parsedJson["IdSport"] == null
          ? null
          : referenceSports
              .firstWhere((sport) => sport.idSport == parsedJson["IdSport"]),
      creatorNotes: parsedJson["CreatorNotes"],
      matchCreatorFirstName: parsedJson["MatchCreatorFirstName"],
      matchCreatorLastName: parsedJson["MatchCreatorLastName"],
      matchCreatorPhoto: parsedJson["MatchCreatorPhoto"],
      idRecurrentMatch: parsedJson["IdRecurrentMatch"],
      blocked: parsedJson["Blocked"] ?? false,
      blockedReason: parsedJson["BlockedReason"] ?? "",
      paymentStatus: decoderPaymentStatus(parsedJson['PaymentStatus']),
      selectedPayment: decoderSelectedPayment(parsedJson['PaymentType']),
      paymentExpirationDate: DateFormat('yyyy-MM-dd HH:mm:ss')
          .parse(parsedJson['PaymentExpirationDate']),
      netCost: double.parse(parsedJson["CostFinal"]),
    );
  }

  factory AppMatch.copyWith(AppMatch refMatch) {
    return AppMatch(
      idMatch: refMatch.idMatch,
      date: refMatch.date,
      cost: refMatch.cost,
      creationDate: refMatch.creationDate,
      creatorNotes: refMatch.creatorNotes,
      idRecurrentMatch: refMatch.idRecurrentMatch,
      court: refMatch.court,
      sport: refMatch.sport,
      startingHour: refMatch.startingHour,
      endingHour: refMatch.endingHour,
      matchCreatorFirstName: refMatch.matchCreatorFirstName,
      matchCreatorLastName: refMatch.matchCreatorLastName,
      matchCreatorPhoto: refMatch.matchCreatorPhoto,
      blocked: refMatch.blocked,
      blockedReason: refMatch.blockedReason,
      paymentExpirationDate: refMatch.paymentExpirationDate,
      paymentStatus: refMatch.paymentStatus,
      selectedPayment: refMatch.selectedPayment,
      netCost: refMatch.netCost,
    );
  }
}
