import 'Hour.dart';

class HourPrice {
  Hour hour;
  int weekday;
  int price;

  HourPrice({
    required this.hour,
    required this.weekday,
    required this.price,
  });

  factory HourPrice.fromJson(Map<String, dynamic> parsedJson) {
    return HourPrice(
      hour: Hour.fromJson(parsedJson["Hour"]),
      weekday: parsedJson["Weekday"],
      price: parsedJson["Price"],
    );
  }
}
