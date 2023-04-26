import 'Hour.dart';

class PriceRule {
  int weekday;
  Hour startingHour;
  Hour endingHour;
  int price;
  int priceRecurrent;

  PriceRule({
    required this.weekday,
    required this.startingHour,
    required this.endingHour,
    required this.price,
    required this.priceRecurrent,
  });
}
