import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/MyCourts/Repository/MyCourtsRepoImp.dart';
import 'package:sandfriends_web/Features/MyCourts/View/PriceListWidget.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Remote/NetworkResponse.dart';
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
  final myCourtsRepo = MyCourtsRepoImp();

  TextEditingController nameController = TextEditingController();

  Court newCourt = Court(description: "", isIndoor: true);

  Court currentCourt = Court(description: "", isIndoor: true);

  List<Court> refCourts = [];
  List<Court> courts = [];
  List<StoreWorkingDay> refStoreWorkingDays = [];
  List<StoreWorkingDay> storeWorkingDays = [];

  bool get courtInfoChanged {
    if (refStoreWorkingDays.isNotEmpty) {
      for (var storeWorkingDay in storeWorkingDays) {
        if (storeWorkingDay !=
            refStoreWorkingDays.firstWhere((strWorkingDay) =>
                strWorkingDay.weekday == storeWorkingDay.weekday)) {
          return true;
        }
      }
    }
    for (var refCourt in refCourts) {
      if (selectedCourtIndex != -1 &&
          refCourt.idStoreCourt == courts[selectedCourtIndex].idStoreCourt) {
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
    return false;
  }

  int _selectedCourtIndex = -1;
  int get selectedCourtIndex => _selectedCourtIndex;
  set selectedCourtIndex(int value) {
    _selectedCourtIndex = value;
    notifyListeners();
  }

  void init(BuildContext context) {
    courts.clear();
    refCourts.clear();
    storeWorkingDays.clear();
    refStoreWorkingDays.clear();
    newCourt = Court(description: "", isIndoor: true);
    selectedCourtIndex = -1;
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
      for (var strWorkingDay
          in Provider.of<DataProvider>(context, listen: false)
              .storeWorkingDays!) {
        refStoreWorkingDays.add(
          StoreWorkingDay.copyFrom(
            strWorkingDay,
          ),
        );
      }
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
    setChangedCourt(selectedCourtIndex);
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
                  .firstWhere((hr) => hr.hour > i),
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

      for (var hourPrice in operationDay.prices) {
        if (hourPrice.endingHour.hour == oldEndingHour.hour + 1) {
          hourPrice.newPriceRule = false;
        } else if (hourPrice.endingHour.hour == newHour.hour + 1) {
          hourPrice.newPriceRule = true;
        }

        if (newHour.hour < oldEndingHour.hour &&
            hourPrice.startingHour.hour > newHour.hour &&
            hourPrice.startingHour.hour <= oldEndingHour.hour) {
          hourPrice.price = nextPrice;
          hourPrice.recurrentPrice = nextRecurrentPrice;
        } else if (newHour.hour > oldEndingHour.hour &&
            hourPrice.startingHour.hour >= oldEndingHour.hour &&
            hourPrice.startingHour.hour < newHour.hour) {
          hourPrice.price = price;
          hourPrice.recurrentPrice = recurrentPrice;
        }
      }
    }

    notifyListeners();
  }

  void onChangedPrice(
    String stringNewPrice,
    PriceRule priceRule,
    OperationDay operationDay,
    bool isRecurrent,
    TextEditingController controller,
  ) {
    int? newPrice = int.tryParse(stringNewPrice);
    if (newPrice == null) {
      controller.text = "0";
      newPrice = 0;
    }
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

  void setIsPriceStandard(OperationDay opDay, bool isNewPriceCustom) {
    if (!isNewPriceCustom) {
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

  void switchTabs(int index) {
    saveChangedCourt();
    setChangedCourt(index);
    selectedCourtIndex = index;
    notifyListeners();
  }

  void saveChangedCourt() {
    if (selectedCourtIndex == -1) {
      newCourt.description = nameController.text;
      newCourt.description = currentCourt.description;
      newCourt.isIndoor = currentCourt.isIndoor;
      newCourt.operationDays.clear();
      for (var opDay in currentCourt.operationDays) {
        newCourt.operationDays.add(
          OperationDay.copyFrom(
            opDay,
          ),
        );
      }
      newCourt.sports.clear();
      for (var sport in currentCourt.sports) {
        newCourt.sports.add(
          AvailableSport.copyFrom(
            sport,
          ),
        );
      }
    } else {
      courts[selectedCourtIndex].description = nameController.text;
      courts[selectedCourtIndex].description = currentCourt.description;
      courts[selectedCourtIndex].isIndoor = currentCourt.isIndoor;
      courts[selectedCourtIndex].operationDays.clear();
      for (var opDay in currentCourt.operationDays) {
        courts[selectedCourtIndex].operationDays.add(
              OperationDay.copyFrom(
                opDay,
              ),
            );
      }
      courts[selectedCourtIndex].sports.clear();
      for (var sport in currentCourt.sports) {
        courts[selectedCourtIndex].sports.add(
              AvailableSport.copyFrom(
                sport,
              ),
            );
      }
    }
    notifyListeners();
  }

  void setChangedCourt(int newIndex) {
    if (newIndex == -1) {
      nameController.text = newCourt.description;
      currentCourt.description = newCourt.description;
      currentCourt.isIndoor = newCourt.isIndoor;
      currentCourt.idStoreCourt = -1;
      currentCourt.operationDays.clear();
      for (var opDay in newCourt.operationDays) {
        currentCourt.operationDays.add(
          OperationDay.copyFrom(
            opDay,
          ),
        );
      }
      currentCourt.sports.clear();
      for (var sport in newCourt.sports) {
        currentCourt.sports.add(
          AvailableSport.copyFrom(
            sport,
          ),
        );
      }
    } else {
      nameController.text = courts[newIndex].description;
      currentCourt.description = courts[newIndex].description;
      currentCourt.isIndoor = courts[newIndex].isIndoor;
      currentCourt.idStoreCourt = courts[newIndex].idStoreCourt;
      currentCourt.operationDays.clear();
      for (var opDay in courts[newIndex].operationDays) {
        currentCourt.operationDays.add(
          OperationDay.copyFrom(
            opDay,
          ),
        );
      }
      currentCourt.sports.clear();
      for (var sport in courts[newIndex].sports) {
        currentCourt.sports.add(
          AvailableSport.copyFrom(
            sport,
          ),
        );
      }
    }
    notifyListeners();
  }

  String courtChangesMissingFields(BuildContext context, Court court) {
    String missingInfo = "";
    if (nameController.text.isEmpty) {
      missingInfo = "Dê um nome a sua quadra!";
    } else if (Provider.of<DataProvider>(context, listen: false)
            .courts
            .any((element) => element.description == nameController.text) &&
        Provider.of<DataProvider>(context, listen: false)
                .courts
                .firstWhere(
                    (element) => element.description == nameController.text)
                .idStoreCourt !=
            court.idStoreCourt) {
      missingInfo = "Já existe uma quadra com esse nome no seu estabelecimento";
    } else if (!court.sports.any((sport) => sport.isAvailable)) {
      missingInfo = "Informe os esportes permitidos na quadra";
    } else if (court.operationDays.any((opDay) => opDay.prices
        .any((price) => price.price == 0 || price.recurrentPrice == 0))) {
      missingInfo = "Opa! Você tem alguma quadra sem preço configurado";
    }
    return missingInfo;
  }

  void addCourt(BuildContext context) {
    String missingInfo = "";

    missingInfo = courtChangesMissingFields(context, currentCourt);

    if (courtInfoChanged) {
      missingInfo =
          "Opa! Você precisa salvar as alterações feitas nas outras quadras antes de adicionar uma nova quadra.";
    }

    if (missingInfo == "") {
      Provider.of<MenuProvider>(context, listen: false).setModalLoading();
      myCourtsRepo
          .addCourt(
        Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
        currentCourt,
      )
          .then((response) {
        if (response.responseStatus == NetworkResponseStatus.success) {
          Map<String, dynamic> responseBody = json.decode(
            response.responseBody!,
          );
          Provider.of<DataProvider>(context, listen: false)
              .setCourts(responseBody);
          init(context);
          Provider.of<MenuProvider>(context, listen: false)
              .setMessageModal("Sua quadra foi criada!", null, true);
        } else if (response.responseStatus ==
            NetworkResponseStatus.expiredToken) {
          Provider.of<MenuProvider>(context, listen: false).logout(context);
        } else {
          Provider.of<MenuProvider>(context, listen: false)
              .setMessageModalFromResponse(response);
        }
      });
    } else {
      Provider.of<MenuProvider>(context, listen: false).setMessageModal(
        missingInfo,
        null,
        true,
      );
    }
  }

  void deleteCourt(
    BuildContext context,
  ) {
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    myCourtsRepo
        .removeCourt(
      Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
      courts[selectedCourtIndex].idStoreCourt!,
    )
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        Map<String, dynamic> responseBody = json.decode(
          response.responseBody!,
        );
        Provider.of<DataProvider>(context, listen: false)
            .setCourts(responseBody);
        init(context);
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModal("Sua quadra foi removida!", null, true);
      } else if (response.responseStatus ==
          NetworkResponseStatus.expiredToken) {
        Provider.of<MenuProvider>(context, listen: false).logout(context);
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(response);
      }
    });
  }

  void saveCourtChanges(
    BuildContext context,
  ) {
    String missingInfo = "";
    for (var court in courts) {
      missingInfo = courtChangesMissingFields(context, currentCourt);
      if (missingInfo != "") {
        Provider.of<MenuProvider>(context, listen: false).setMessageModal(
          missingInfo,
          "Verifique ${court.description}",
          true,
        );
        return;
      }
    }
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    List<Court> changedCourts = [];
    for (var court in courts) {
      Court refCourt = refCourts.firstWhere(
          (element) => element.idStoreCourt == currentCourt.idStoreCourt);
      if (court.idStoreCourt == courts[selectedCourtIndex].idStoreCourt) {
        if (currentCourt != refCourt) {
          changedCourts.add(currentCourt);
        }
      } else {
        if (court != refCourt) {
          changedCourts.add(court);
        }
      }
    }
    myCourtsRepo
        .saveCourtChanges(
      Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
      changedCourts,
    )
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        Map<String, dynamic> responseBody = json.decode(
          response.responseBody!,
        );
        Provider.of<DataProvider>(context, listen: false)
            .setCourts(responseBody);
        init(context);
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModal("Suas quadras foram atualizadas!", null, true);
      } else if (response.responseStatus ==
          NetworkResponseStatus.expiredToken) {
        Provider.of<MenuProvider>(context, listen: false).logout(context);
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(response);
      }
    });
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
