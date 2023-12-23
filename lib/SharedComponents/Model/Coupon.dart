import 'package:sandfriends_web/SharedComponents/Model/EnumCouponStatus.dart';
import 'package:sandfriends_web/Utils/TypesExtensions.dart';

import 'EnumDiscountType.dart';
import 'Hour.dart';
import 'package:intl/intl.dart';

class Coupon {
  int idCoupon;
  String couponCode;
  double value;
  EnumDiscountType discountType;
  bool isValid;
  DateTime creationDate;
  DateTime startingDate;
  DateTime endingDate;
  Hour hourBegin;
  Hour hourEnd;
  int timesUsed;
  double profit;

  String get valueText {
    if (discountType == EnumDiscountType.Fixed) {
      return value.formatPrice();
    } else {
      return "${value.toStringAsFixed(0)}%";
    }
  }

  String get hourDescription =>
      "${hourBegin.hourString} - ${hourEnd.hourString}";

  String get dateDescription =>
      "${DateFormat('dd/MM').format(startingDate)} - ${DateFormat('dd/MM').format(endDateTime)}";
  DateTime get startDateTime => DateFormat("dd/MM/yyyy HH:mm").parse(
        "${DateFormat('dd/MM/yyyy').format(
          startingDate,
        )} ${hourBegin.hourString}",
      );

  DateTime get endDateTime => DateFormat("dd/MM/yyyy HH:mm").parse(
        "${DateFormat('dd/MM/yyyy').format(
          endingDate,
        )} ${hourEnd.hourString}",
      );

  bool get isValidToday {
    DateTime now = DateTime.now();
    DateTime start = startDateTime;
    DateTime end = endDateTime;

    return now.isAfter(start) && now.isBefore(end);
  }

  bool get canBeDisabled =>
      isValidToday || DateTime.now().isBefore(startDateTime);

  EnumCouponStatus get couponStatus {
    if (!isValid) {
      return EnumCouponStatus.Invalid;
    } else {
      if (isValidToday) {
        return EnumCouponStatus.Valid;
      } else if (DateTime.now().isAfter(endDateTime)) {
        return EnumCouponStatus.Expired;
      } else {
        return EnumCouponStatus.Unavailable;
      }
    }
  }

  Coupon({
    required this.idCoupon,
    required this.couponCode,
    required this.value,
    required this.discountType,
    required this.isValid,
    required this.creationDate,
    required this.startingDate,
    required this.endingDate,
    required this.hourBegin,
    required this.hourEnd,
    required this.timesUsed,
    required this.profit,
  });

  factory Coupon.fromJson(
    Map<String, dynamic> json,
    List<Hour> referenceHours,
  ) {
    return Coupon(
      idCoupon: json["IdCoupon"],
      couponCode: json["Code"],
      discountType: getDiscountTypeFromString(
        json["DiscountType"],
      ),
      value: double.parse(
        json["Value"],
      ),
      creationDate: DateFormat("dd/MM/yyyy").parse(
        json["DateCreated"],
      ),
      startingDate: DateFormat("dd/MM/yyyy").parse(
        json["DateBeginValid"],
      ),
      endingDate: DateFormat("dd/MM/yyyy").parse(
        json["DateEndValid"],
      ),
      hourBegin: referenceHours.firstWhere(
        (hour) => hour.hour == json["IdTimeBeginValid"],
      ),
      hourEnd: referenceHours.firstWhere(
        (hour) => hour.hour == json["IdTimeEndValid"],
      ),
      isValid: json["IsValid"],
      timesUsed: json["TimesUsed"],
      profit: double.parse(
        json["Profit"].toString(),
      ),
    );
  }
}
