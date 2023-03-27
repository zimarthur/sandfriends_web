import 'Hour.dart';

class HourPrice {
  Hour startingHour;
  Hour endingHour;
  int weekday;
  bool allowReccurrent;
  int price;
  int recurrentPrice;
  bool newPriceRule = false;

  HourPrice({
    required this.startingHour,
    required this.weekday,
    required this.allowReccurrent,
    required this.price,
    required this.recurrentPrice,
    required this.endingHour,
  });
}
