import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/WorkingHoursWidget.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';

import '../../../../SharedComponents/Model/Court.dart';
import '../../../../SharedComponents/Model/Hour.dart';
import '../../../../SharedComponents/Model/PriceRule.dart';
import '../../../ViewModel/DashboardViewModel.dart';

class MyCourtsViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  bool isPriceStandard = true;

  String newCourtName = "";
  bool newCourtIsIndoor = true;
  List<AvailableSport> newCourtSports = [];
  List<HourPrice> newCourtHourPrices = [];

  Court currentCourt = Court(description: "", isIndoor: true);

  List<Court> courts = [];

  bool _courtInfoChanged = false;
  bool get courtInfoChanged => _courtInfoChanged;
  set courtInfoChanged(bool value) {
    _courtInfoChanged = value;
    notifyListeners();
  }

  int _selectedCourtIndex = -1;
  int get selectedCourtIndex => _selectedCourtIndex;
  set selectedCourtIndex(int value) {
    _selectedCourtIndex = value;
    notifyListeners();
  }

  void init(BuildContext context) {
    courts = List<Court>.from(
        Provider.of<DataProvider>(context, listen: false).courts);

    Provider.of<DataProvider>(context, listen: false)
        .availableSports
        .forEach((sport) {
      newCourtSports.add(AvailableSport(sport: sport, isAvailable: false));
    });
    Provider.of<DataProvider>(context, listen: false)
        .operationDays
        .forEach((opDay) {
      for (int hour = opDay.startingHour.hour;
          hour < opDay.endingHour.hour;
          hour++) {
        newCourtHourPrices.add(
          HourPrice(
            startingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere((avHour) => avHour.hour == hour),
            endingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere((avHour) => avHour.hour == hour + 1),
            weekday: opDay.weekDay,
            allowReccurrent: true,
            price: 0,
            recurrentPrice: 0,
          ),
        );
      }
    });
  }

  void setWorkingHoursWidget(
      BuildContext context, MyCourtsViewModel viewModel) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      WorkingHoursWidget(viewModel: viewModel),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalSuccess();
  }

  void saveNewOperationDays(
      BuildContext context, List<OperationDay> newOperationDays) {
    Provider.of<DataProvider>(context, listen: false).operationDays.clear();
    newOperationDays.forEach((opDay) {
      Provider.of<DataProvider>(context, listen: false)
          .operationDays
          .add(opDay);
      updateCourtWorkingHours(opDay, context);
    });
    returnMainView(context);
  }

  void updateCourtWorkingHours(OperationDay opDay, BuildContext context) {
    if (newCourtHourPrices
        .where((hourPrice) => hourPrice.weekday == opDay.weekDay)
        .isEmpty) {
      for (int hour = opDay.startingHour.hour;
          hour < opDay.endingHour.hour;
          hour++) {
        newCourtHourPrices.add(HourPrice(
            startingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere((avHour) => avHour.hour == hour),
            endingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere((avHour) => avHour.hour == hour + 1),
            weekday: opDay.weekDay,
            allowReccurrent: true,
            price: 0,
            recurrentPrice: 0));
      }
    } else {
      newCourtHourPrices = newCourtHourPrices
          .where((hourPrice) =>
              hourPrice.weekday == opDay.weekDay &&
              hourPrice.startingHour.hour >= opDay.startingHour.hour &&
              hourPrice.startingHour.hour <= opDay.endingHour.hour)
          .toList();
    }
    switchTabs(context, selectedCourtIndex);
  }

  void setNewRuleStartHour(int dayIndex, String newHourString,
      BuildContext context, PriceRule priceRule) {
    Hour newHour = Provider.of<DataProvider>(context, listen: false)
        .availableHours
        .firstWhere((hour) => hour.hourString == newHourString);
    currentCourt.prices
        .where((hourPrice) => hourPrice.weekday == dayIndex)
        .forEach((hourPrice) {
      if (hourPrice.startingHour.hour == newHour.hour) {
        hourPrice.newPriceRule = true;
      } else if (hourPrice.startingHour.hour == priceRule.startingHour.hour) {
        hourPrice.newPriceRule = false;
      }
    });
    notifyListeners();
  }

  void setNewRuleEndHour(int dayIndex, String newHourString,
      BuildContext context, PriceRule priceRule) {
    Hour newHour = Provider.of<DataProvider>(context, listen: false)
        .availableHours
        .firstWhere((hour) => hour.hourString == newHourString);
    currentCourt.prices
        .where((hourPrice) => hourPrice.weekday == dayIndex)
        .forEach((hourPrice) {
      if (hourPrice.startingHour.hour == newHour.hour) {
        hourPrice.newPriceRule = true;
      } else if (hourPrice.startingHour.hour == priceRule.endingHour.hour) {
        hourPrice.newPriceRule = false;
      }
      print(hourPrice.startingHour.hourString);
      print(hourPrice.newPriceRule);
    });
    notifyListeners();
  }

  void priceChange(
      String newPrice, PriceRule priceRule, int dayIndex, bool isRecurrent) {
    currentCourt.prices
        .where((hourPrice) => hourPrice.weekday == dayIndex)
        .forEach((hourPrice) {
      if (hourPrice.startingHour.hour >= priceRule.startingHour.hour ||
          hourPrice.startingHour.hour < priceRule.endingHour.hour) {
        if (isRecurrent) {
          hourPrice.recurrentPrice = int.parse(newPrice);
        } else {
          hourPrice.price = int.parse(newPrice);
        }
      }
    });
  }

  void setIsPriceStandart(bool newIsPriceStandard, int dayIndex) {
    isPriceStandard = newIsPriceStandard;
    if (newIsPriceStandard) {
      int refPrice = currentCourt.priceRules
          .where((element) => element.weekday == dayIndex)
          .first
          .price;
      int refRecurrentPrice = currentCourt.priceRules
          .where((element) => element.weekday == dayIndex)
          .first
          .priceRecurrent;
      currentCourt.prices
          .where((hourPrice) => hourPrice.weekday == dayIndex)
          .forEach((hourPrice) {
        hourPrice.newPriceRule = false;
        hourPrice.price = refPrice;
        hourPrice.recurrentPrice = refRecurrentPrice;
      });
    }
    notifyListeners();
  }

  void switchTabs(BuildContext context, int index) {
    selectedCourtIndex = index;
    if (selectedCourtIndex == -1) {
      nameController.text = newCourtName;
      currentCourt.isIndoor = newCourtIsIndoor;
      currentCourt.prices = newCourtHourPrices;
      currentCourt.sports = newCourtSports;
    } else {
      nameController.text = courts[selectedCourtIndex].description;
      currentCourt.isIndoor = courts[selectedCourtIndex].isIndoor;
      currentCourt.prices = courts[selectedCourtIndex].prices;
      currentCourt.sports = courts[selectedCourtIndex].sports;
    }
    notifyListeners();
  }

  void addCourt(BuildContext context) {
    if (nameController.text.isEmpty) print("sem nome");

    if (Provider.of<DataProvider>(context, listen: false)
        .courts
        .any((element) => element.description == nameController.text))
      print("nome já existe");

    if (courts[selectedCourtIndex]
            .sports
            .any((element) => element.isAvailable == true) ==
        false) print("selecione esporte");

    //VAI TER Q ALTERAR PRA RECEBER O ID DO SERVIDOR
    var newCourt = Court(
        idStoreCourt:
            Provider.of<DataProvider>(context, listen: false).courts.length,
        description: nameController.text,
        isIndoor: courts[selectedCourtIndex].isIndoor);
    courts[selectedCourtIndex].sports.forEach((sport) {
      newCourt.sports.add(sport);
    });

    Provider.of<DataProvider>(context, listen: false).courts.add(newCourt);
    switchTabs(
        context,
        Provider.of<DataProvider>(context, listen: false)
            .courts
            .where((element) => element.idStoreCourt == newCourt.idStoreCourt)
            .first
            .idStoreCourt!);
  }

  void deleteCourt(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false)
        .courts
        .removeAt(selectedCourtIndex);
    selectedCourtIndex = -1;
  }

  void checkCourtInfoChanges(BuildContext context) {
    if (selectedCourtIndex == -1) {
      courtInfoChanged = false;
    } else {
      bool changedSport = false;
      courts[selectedCourtIndex].sports.forEach((formSport) {
        print("aa ${formSport.sport.description}");
        print("aa ${formSport.isAvailable}");
        Provider.of<DataProvider>(context, listen: false)
            .courts[selectedCourtIndex]
            .sports
            .forEach((sport) {
          if (sport.sport.idSport == formSport.sport.idSport) {
            print("bb ${sport.sport.description}");
            print("bb ${sport.isAvailable}");
            if (sport.isAvailable == formSport.isAvailable) {
              print("igual");
            } else {
              print("dif");
            }
          }
        });
      });
      courtInfoChanged = nameController.text !=
              Provider.of<DataProvider>(context, listen: false)
                  .courts[selectedCourtIndex]
                  .description ||
          courts[selectedCourtIndex].isIndoor !=
              Provider.of<DataProvider>(context, listen: false)
                  .courts[selectedCourtIndex]
                  .isIndoor ||
          changedSport;
    }
  }
}
