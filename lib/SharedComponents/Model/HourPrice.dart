import 'Hour.dart';

class HourPrice {
  Hour startingHour;
  Hour endingHour;
  int price;
  int? recurrentPrice;
  bool newPriceRule = false;

  HourPrice({
    required this.startingHour,
    required this.price,
    required this.recurrentPrice,
    required this.endingHour,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is HourPrice == false) return false;
    HourPrice otherHourPrice = other as HourPrice;
    return startingHour.hour == otherHourPrice.startingHour.hour &&
        endingHour.hour == otherHourPrice.endingHour.hour &&
        price == otherHourPrice.price &&
        recurrentPrice == otherHourPrice.recurrentPrice;
  }

  @override
  int get hashCode =>
      startingHour.hashCode ^ endingHour.hashCode ^ price.hashCode;

  factory HourPrice.copyFrom(HourPrice refHourPrice) {
    return HourPrice(
      startingHour: refHourPrice.startingHour,
      price: refHourPrice.price,
      recurrentPrice: refHourPrice.recurrentPrice,
      endingHour: refHourPrice.endingHour,
    );
  }
}
