import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';
import 'package:sandfriends_web/SharedComponents/Model/PriceRule.dart';

import 'Sport.dart';

class Court {
  int idStoreCourt;
  String description;
  bool isIndoor;

  List<AvailableSport> sports = [];
  List<HourPrice> prices = [];

  List<PriceRule> get priceRules {
    List<PriceRule> calculatedRules = [];
    for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
      List<HourPrice> filteredPrices =
          prices.where((hourPrice) => hourPrice.weekday == dayIndex).toList();
      PriceRule? newPriceRule;
      for (int priceIndex = 0;
          priceIndex < filteredPrices.length;
          priceIndex++) {
        if (priceIndex == 0) {
          newPriceRule = PriceRule(
            weekday: dayIndex,
            startingHour: filteredPrices[priceIndex].hour,
            endingHour: filteredPrices[priceIndex].hour,
            price: filteredPrices[priceIndex].price,
            priceRecurrent: filteredPrices[priceIndex].recurrentPrice,
          );
        } else if (filteredPrices[priceIndex].price != newPriceRule!.price ||
            filteredPrices[priceIndex].recurrentPrice !=
                newPriceRule.priceRecurrent) {
          newPriceRule.endingHour = filteredPrices[priceIndex - 1].hour;
          calculatedRules.add(newPriceRule);
          newPriceRule = PriceRule(
            weekday: dayIndex,
            startingHour: filteredPrices[priceIndex].hour,
            endingHour: filteredPrices[priceIndex].hour,
            price: filteredPrices[priceIndex].price,
            priceRecurrent: filteredPrices[priceIndex].recurrentPrice,
          );
        } else if (priceIndex == filteredPrices.length - 1) {
          newPriceRule.endingHour = filteredPrices[priceIndex].hour;
          calculatedRules.add(newPriceRule);
          newPriceRule = PriceRule(
            weekday: dayIndex,
            startingHour: filteredPrices[priceIndex].hour,
            endingHour: filteredPrices[priceIndex].hour,
            price: filteredPrices[priceIndex].price,
            priceRecurrent: filteredPrices[priceIndex].recurrentPrice,
          );
        }
      }
    }
    return calculatedRules;
  }

  Court({
    required this.idStoreCourt,
    required this.description,
    required this.isIndoor,
  });

  factory Court.fromJson(Map<String, dynamic> parsedJson) {
    final newCourt = Court(
      idStoreCourt: parsedJson["IdStoreCourt"],
      description: parsedJson["Description"],
      isIndoor: parsedJson["IsIndoor"],
    );

    for (int i = 0; i < parsedJson["Prices"].length; i++) {
      newCourt.prices.add(HourPrice.fromJson(parsedJson["Prices"][i]));
    }

    return newCourt;
  }
}
