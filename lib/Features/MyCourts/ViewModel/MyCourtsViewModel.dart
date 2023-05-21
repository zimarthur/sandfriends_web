import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/MyCourts/View/PriceListWidget.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/HourPrice.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/StoreWorkingHours.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../../SharedComponents/Model/Court.dart';
import '../../../SharedComponents/Model/Hour.dart';
import '../../../SharedComponents/Model/PriceRule.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../View/WorkingHoursModal.dart';

class MyCourtsViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  Court newCourt = Court(description: "", isIndoor: true);

  Court currentCourt = Court(description: "", isIndoor: true);

  List<Court> refCourts = [];
  List<Court> courts = [];
  List<StoreWorkingDay> storeWorkingDays = [];

  bool get courtInfoChanged {
    for (var refCourt in refCourts) {
      if (selectedCourtIndex != -1) {
        if (refCourt.idStoreCourt == courts[selectedCourtIndex].idStoreCourt) {
          print("");
          print(refCourt.description);
          print(currentCourt.description);
          print("");
          if (refCourt != currentCourt) {
            return true;
          }
        } else {
          if (refCourt !=
              courts.firstWhere(
                  (court) => court.idStoreCourt == refCourt.idStoreCourt)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  int _selectedCourtIndex = -1;
  int get selectedCourtIndex => _selectedCourtIndex;
  set selectedCourtIndex(int value) {
    _selectedCourtIndex = value;
    notifyListeners();
  }

  void init(BuildContext context) {
    for (var court
        in Provider.of<DataProvider>(context, listen: false).courts) {
      courts.add(
        Court.copyFrom(
          court,
        ),
      );
      refCourts.add(
        Court.copyFrom(
          court,
        ),
      );
    }

    Provider.of<DataProvider>(context, listen: false).availableSports.forEach(
      (sport) {
        newCourt.sports.add(
          AvailableSport(
            sport: sport,
            isAvailable: false,
          ),
        );
      },
    );
    for (int weekday = 0; weekday < 7; weekday++) {
      newCourt.operationDays.add(
        OperationDay(
          weekday: weekday,
        ),
      );
    }
    if (Provider.of<DataProvider>(context, listen: false).storeWorkingDays !=
        null) {
      saveNewStoreWorkingSDays(
        context,
        Provider.of<DataProvider>(context, listen: false).storeWorkingDays!,
      );
    }
  }

  void setWorkingHoursWidget(
      BuildContext context, MyCourtsViewModel viewModel) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      WorkingHoursModal(viewModel: viewModel),
    );
  }

  void setPriceListWidget(MyCourtsViewModel viewModel, BuildContext context,
      List<HourPrice> hourPriceList, int dayIndex) {
    Provider.of<MenuProvider>(context, listen: false)
        .setModalForm(PriceListWidget(
      viewModel: viewModel,
      hourPriceList: hourPriceList,
      dayIndex: dayIndex,
    ));
  }

  void closeModal(
    BuildContext context,
  ) {
    Provider.of<MenuProvider>(context, listen: false).closeModal();
  }

  void saveNewStoreWorkingSDays(
      BuildContext context, List<StoreWorkingDay> newStoreWorkingDays) {
    storeWorkingDays.clear();
    for (var newStoreWorkingDay in newStoreWorkingDays) {
      storeWorkingDays.add(
        StoreWorkingDay.copyFrom(
          newStoreWorkingDay,
        ),
      );
      updateCourtWorkingHours(newStoreWorkingDay, context);
    }
    switchTabs(context, selectedCourtIndex);
    notifyListeners();
    closeModal(context);
  }

  void updateCourtWorkingHours(
      StoreWorkingDay storeWorkingDay, BuildContext context) {
    if (storeWorkingDay.isEnabled) {
      updateHourLimits(
          storeWorkingDay,
          newCourt.operationDays
              .firstWhere((opDay) => opDay.weekday == storeWorkingDay.weekday)
              .prices,
          context);
      for (var court in courts) {
        updateHourLimits(
            storeWorkingDay,
            court.operationDays
                .firstWhere((opDay) => opDay.weekday == storeWorkingDay.weekday)
                .prices,
            context);
      }
    } else {
      newCourt.operationDays
          .firstWhere((opDay) => opDay.weekday == storeWorkingDay.weekday)
          .prices
          .clear();
      for (var court in courts) {
        court.operationDays
            .firstWhere((opDay) => opDay.weekday == storeWorkingDay.weekday)
            .prices
            .clear();
      }
    }
  }

  void updateHourLimits(StoreWorkingDay storeWorkingDay, List<HourPrice> prices,
      BuildContext context) {
    if (prices.isEmpty) {
      for (int i = storeWorkingDay.startingHour!.hour;
          i < storeWorkingDay.endingHour!.hour;
          i++) {
        prices.add(
          HourPrice(
            startingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere((hr) => hr.hour == i),
            price: 0,
            recurrentPrice: 0,
            endingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .firstWhere((hr) => hr.hour > i),
          ),
        );
      }
    } else {
      Hour minHour = prices
          .reduce((a, b) => a.startingHour.hour < b.startingHour.hour ? a : b)
          .startingHour;
      Hour maxHour = prices
          .reduce((a, b) => a.endingHour.hour > b.endingHour.hour ? a : b)
          .endingHour;

      if (minHour.hour < storeWorkingDay.startingHour!.hour) {
        prices.removeWhere((hourPrice) =>
            hourPrice.startingHour.hour < storeWorkingDay.startingHour!.hour);
      } else {
        for (int i = storeWorkingDay.startingHour!.hour;
            i < minHour.hour;
            i++) {
          prices.add(
            HourPrice(
              startingHour: Provider.of<DataProvider>(context, listen: false)
                  .availableHours
                  .firstWhere((hr) => hr.hour == i),
              price: prices.first.price,
              recurrentPrice: prices.first.recurrentPrice,
              endingHour: Provider.of<DataProvider>(context, listen: false)
                  .availableHours
                  .firstWhere((hr) => hr.hour >= i),
            ),
          );
        }
      }
      if (maxHour.hour > storeWorkingDay.endingHour!.hour) {
        prices.removeWhere((hourPrice) =>
            hourPrice.endingHour.hour > storeWorkingDay.endingHour!.hour);
      } else {
        for (int i = maxHour.hour; i < storeWorkingDay.endingHour!.hour; i++) {
          prices.add(
            HourPrice(
              startingHour: Provider.of<DataProvider>(context, listen: false)
                  .availableHours
                  .firstWhere((hr) => hr.hour == i),
              price: prices.last.price,
              recurrentPrice: prices.last.recurrentPrice,
              endingHour: Provider.of<DataProvider>(context, listen: false)
                  .availableHours
                  .firstWhere((hr) => hr.hour >= i),
            ),
          );
        }
      }
    }
  }

  void onChangedRuleStartingHour(
    BuildContext context,
    OperationDay operationDay,
    Hour oldStartingHour,
    String? newHourString,
  ) {
    Hour newHour = Provider.of<DataProvider>(context, listen: false)
        .availableHours
        .firstWhere((hour) => hour.hourString == newHourString);
    if (newHourString == null || newHour.hour == oldStartingHour.hour) return;
    if (oldStartingHour.hour == operationDay.startingHour.hour) {
      operationDay.prices
          .firstWhere(
              (hourPrice) => hourPrice.startingHour.hour == newHour.hour)
          .newPriceRule = true;
    } else {
      int price = operationDay.prices
          .firstWhere(
              (hrPrice) => hrPrice.startingHour.hour == oldStartingHour.hour)
          .price;
      int? recurrentPrice = operationDay.prices
          .firstWhere(
              (hrPrice) => hrPrice.startingHour.hour == oldStartingHour.hour)
          .recurrentPrice;
      int previousPrice = operationDay.prices
          .lastWhere(
              (hrPrice) => hrPrice.startingHour.hour < oldStartingHour.hour)
          .price;
      int? previousRecurrentPrice = operationDay.prices
          .lastWhere(
              (hrPrice) => hrPrice.startingHour.hour < oldStartingHour.hour)
          .recurrentPrice;
      for (var hourPrice in operationDay.prices) {
        if (hourPrice.startingHour.hour == newHour.hour) {
          hourPrice.newPriceRule = true;
        } else if (hourPrice.startingHour.hour == oldStartingHour.hour) {
          hourPrice.newPriceRule = false;
        }
        if (newHour.hour < oldStartingHour.hour &&
            hourPrice.startingHour.hour >= newHour.hour &&
            hourPrice.startingHour.hour <= oldStartingHour.hour) {
          hourPrice.price = price;
          hourPrice.recurrentPrice = recurrentPrice;
        } else if (newHour.hour > oldStartingHour.hour &&
            hourPrice.startingHour.hour > oldStartingHour.hour &&
            hourPrice.startingHour.hour < newHour.hour) {
          hourPrice.price = previousPrice;
          hourPrice.recurrentPrice = previousRecurrentPrice;
        }
      }
    }
    notifyListeners();
  }

  void onChangedRuleEndingHour(
    BuildContext context,
    OperationDay operationDay,
    Hour oldEndingHour,
    String? newHourString,
  ) {
    Hour newHour = Provider.of<DataProvider>(context, listen: false)
        .availableHours
        .firstWhere((hour) => hour.hourString == newHourString);
    if (newHourString == null || newHour.hour == oldEndingHour.hour) return;
    if (oldEndingHour.hour == operationDay.endingHour.hour) {
      operationDay.prices
          .firstWhere(
              (hourPrice) => hourPrice.startingHour.hour == newHour.hour)
          .newPriceRule = true;
    } else {
      int price = operationDay.prices
          .lastWhere((hrPrice) => hrPrice.endingHour.hour == oldEndingHour.hour)
          .price;
      int? recurrentPrice = operationDay.prices
          .lastWhere((hrPrice) => hrPrice.endingHour.hour == oldEndingHour.hour)
          .recurrentPrice;
      int nextPrice = operationDay.prices
          .firstWhere((hrPrice) => hrPrice.endingHour.hour == newHour.hour)
          .price;
      int? nextRecurrentPrice = operationDay.prices
          .firstWhere((hrPrice) => hrPrice.endingHour.hour == newHour.hour)
          .recurrentPrice;
      print("newHour: ${newHour.hourString}");
      print("oldHour: ${oldEndingHour.hourString}");
      for (var hourPrice in operationDay.prices) {
        print("Current starting hour: ${hourPrice.startingHour.hourString}");
        print("Current ending hour: ${hourPrice.endingHour.hourString}");
        if (hourPrice.endingHour.hour == oldEndingHour.hour + 1) {
          hourPrice.newPriceRule = false;
          print("starting ${hourPrice.startingHour} = false");
          print("ending ${hourPrice.endingHour} = false");
        } else if (hourPrice.endingHour.hour == newHour.hour + 1) {
          hourPrice.newPriceRule = true;
          print("starting ${hourPrice.startingHour} = true");
          print("ending ${hourPrice.endingHour} = true");
        }

        if (newHour.hour < oldEndingHour.hour &&
            hourPrice.startingHour.hour > newHour.hour &&
            hourPrice.startingHour.hour <= oldEndingHour.hour) {
          print("hourPrice.price = nextPrice");
          hourPrice.price = nextPrice;
          hourPrice.recurrentPrice = nextRecurrentPrice;
        } else if (newHour.hour > oldEndingHour.hour &&
            hourPrice.startingHour.hour >= oldEndingHour.hour &&
            hourPrice.startingHour.hour < newHour.hour) {
          print("hourPrice.price = price");
          hourPrice.price = price;
          hourPrice.recurrentPrice = recurrentPrice;
        }
      }
    }

    notifyListeners();
  }

  void onChangedPrice(String stringNewPrice, PriceRule priceRule,
      OperationDay operationDay, bool isRecurrent) {
    int newPrice = int.parse(stringNewPrice);
    for (var hourPrice in operationDay.prices) {
      if (hourPrice.startingHour.hour >= priceRule.startingHour.hour &&
          hourPrice.startingHour.hour < priceRule.endingHour.hour) {
        if (isRecurrent) {
          hourPrice.recurrentPrice = newPrice;
        } else {
          hourPrice.price = newPrice;
        }
      }
    }
    notifyListeners();
  }

  void setIsPriceStandard(OperationDay opDay, bool newIsPriceStandard) {
    if (newIsPriceStandard) {
      int standardPrice = opDay.prices.first.price;
      int? standardRecurrentPrice = opDay.prices.first.recurrentPrice;
      for (var hourPrice in opDay.prices) {
        hourPrice.newPriceRule = false;
        hourPrice.price = standardPrice;
        if (opDay.allowReccurrent) {
          hourPrice.recurrentPrice = standardRecurrentPrice;
        }
      }
    }
    notifyListeners();
  }

  void setAllowRecurrent(OperationDay opDay, bool allowReccurrent) {
    if (allowReccurrent) {
      for (var hourPrice in opDay.prices) {
        hourPrice.recurrentPrice = hourPrice.price;
      }
    } else {
      for (var hourPrice in opDay.prices) {
        hourPrice.recurrentPrice = null;
      }
    }
    notifyListeners();
  }

  void switchTabs(BuildContext context, int index) {
    selectedCourtIndex = index;
    if (selectedCourtIndex == -1) {
      nameController.text = newCourt.description;
      currentCourt.description = newCourt.description;
      currentCourt.isIndoor = newCourt.isIndoor;
      currentCourt.operationDays.clear();
      for (var opDay in newCourt.operationDays) {
        currentCourt.operationDays.add(
          OperationDay.copyFrom(
            opDay,
          ),
        );
      }

      currentCourt.sports = newCourt.sports;
    } else {
      nameController.text = courts[selectedCourtIndex].description;
      currentCourt.description = courts[selectedCourtIndex].description;
      currentCourt.isIndoor = courts[selectedCourtIndex].isIndoor;
      currentCourt.operationDays = courts[selectedCourtIndex].operationDays;
      currentCourt.sports = courts[selectedCourtIndex].sports;
    }
    notifyListeners();
  }

  void resetNewCourtStats() {
    // newCourtName = "";
    // newCourtIsIndoor = true;
    // List<AvailableSport> newListSports = [];

    // for (var avSport in newCourtSports) {
    //   newListSports
    //       .add(AvailableSport(sport: avSport.sport, isAvailable: false));
    // }
    // newCourtSports = newListSports;

    // List<HourPrice> newListHourPrices = [];
    // for (var hourPrice in newCourtHourPrices) {
    //   newListHourPrices.add(HourPrice(
    //       startingHour: hourPrice.startingHour,
    //       weekday: hourPrice.weekday,
    //       allowReccurrent: hourPrice.allowReccurrent,
    //       price: 0,
    //       recurrentPrice: 0,
    //       endingHour: hourPrice.endingHour));
    // }
    // newCourtHourPrices = newListHourPrices;
  }

  void addCourt(BuildContext context) {
    if (nameController.text.isEmpty) print("sem nome");

    if (Provider.of<DataProvider>(context, listen: false)
        .courts
        .any((element) => element.description == nameController.text)) {
      print("nome já existe");
    }

    if (currentCourt.sports.any((element) => element.isAvailable == true) ==
        false) print("selecione esporte");

    //VAI TER Q ALTERAR PRA RECEBER O ID DO SERVIDOR
    var newCourt = Court(
        idStoreCourt:
            Provider.of<DataProvider>(context, listen: false).courts.length,
        description: nameController.text,
        isIndoor: currentCourt.isIndoor);

    for (var sport in currentCourt.sports) {
      newCourt.sports.add(sport);
    }
    // for (var hourPrice in currentCourt.prices) {
    //   newCourt.prices.add(hourPrice);
    // }

    Provider.of<DataProvider>(context, listen: false).courts.add(newCourt);
    courts.add(newCourt);
    resetNewCourtStats();
    switchTabs(
        context,
        Provider.of<DataProvider>(context, listen: false)
            .courts
            .firstWhere(
                (element) => element.idStoreCourt == newCourt.idStoreCourt)
            .idStoreCourt!);
    notifyListeners();
  }

  void deleteCourt(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false)
        .courts
        .removeAt(selectedCourtIndex);
    selectedCourtIndex = -1;
  }

  void onChangedCourtName(String newText) {
    currentCourt.description = newText;
    notifyListeners();
  }

  void onChangedIsIndoor(bool? isIndoor) {
    if (isIndoor != null) {
      currentCourt.isIndoor = isIndoor;
      notifyListeners();
    }
  }

  void onChangedSport(AvailableSport changedSport, bool? newValue) {
    if (newValue != null) {
      currentCourt.sports
          .firstWhere(
              (sport) => sport.sport.idSport == changedSport.sport.idSport)
          .isAvailable = newValue;
      notifyListeners();
    }
  }
}
