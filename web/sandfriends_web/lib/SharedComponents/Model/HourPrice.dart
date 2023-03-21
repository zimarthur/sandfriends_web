import 'Hour.dart';

class HourPrice {
  Hour hour;
  int weekday;
  bool allowReccurrent;
  int price;
  int recurrentPrice;

  HourPrice({
    required this.hour,
    required this.weekday,
    required this.allowReccurrent,
    required this.price,
    required this.recurrentPrice,
  });

  factory HourPrice.fromJson(Map<String, dynamic> parsedJson) {
    return HourPrice(
      hour: Hour.fromJson(parsedJson["Hour"]),
      weekday: parsedJson["Weekday"],
      allowReccurrent: parsedJson["AllowRecurrent"],
      price: parsedJson["Price"],
      recurrentPrice: parsedJson["RecurrentPrice"],
    );
  }
}
