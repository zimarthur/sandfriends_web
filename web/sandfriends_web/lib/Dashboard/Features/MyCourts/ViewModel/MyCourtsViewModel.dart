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
import '../../../ViewModel/DashboardViewModel.dart';

class MyCourtsViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  String currentCourtName = "";
  bool currentCourtIsIndoor = true;
  List<AvailableSport> currentCourtSports = [];

  List<Court> courts = [];
  List<HourPrice> currentCourtHourPrices = [];

  List<OperationDay> operationDays = [];

  bool _isNewCourt = true;
  bool get isNewCourt => _isNewCourt;
  set isNewCourt(bool value) {
    _isNewCourt = value;
    notifyListeners();
  }

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
    operationDays = List<OperationDay>.from(
        Provider.of<DataProvider>(context, listen: false).operationDays);
    courts = List<Court>.from(
        Provider.of<DataProvider>(context, listen: false).courts);
    setFields(context);
  }

  void setWorkingHours(BuildContext context, MyCourtsViewModel viewModel) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      WorkingHoursWidget(viewModel: viewModel),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalSuccess();
  }

  void saveNewOperationDays(
      BuildContext context, List<OperationDay> newOperationDays) {
    operationDays = newOperationDays;
    returnMainView(context);
  }

  void switchTabs(BuildContext context, int index) {
    selectedCourtIndex = index;
    isNewCourt = index == -1;
    setFields(context);

    notifyListeners();
  }

  void setFields(BuildContext context) {
    if (selectedCourtIndex == -1) {
      nameController.text = "";
      currentCourtIsIndoor = true;
      currentCourtSports.clear();
      Provider.of<DataProvider>(context, listen: false)
          .availableSports
          .forEach((sport) {
        currentCourtSports
            .add(AvailableSport(sport: sport, isAvailable: false));
      });
      currentCourtHourPrices.clear();
      operationDays.forEach((operationDay) {
        for (int i = operationDay.startingHour.hour;
            i < operationDay.endingHour.hour;
            i++) {
          currentCourtHourPrices.add(
            HourPrice(
              hour: Provider.of<DataProvider>(context, listen: false)
                  .availableHours
                  .firstWhere((hour) => hour.hour == i),
              weekday: operationDay.weekDay,
              price: 0,
            ),
          );
        }
      });
    } else {
      nameController.text = courts[selectedCourtIndex].description;
      currentCourtIsIndoor = courts[selectedCourtIndex].isIndoor;
      currentCourtSports.clear();
      courts[selectedCourtIndex].sports.forEach((sport) {
        currentCourtSports.add(sport);
      });
      currentCourtHourPrices.clear();
      operationDays.forEach((operationDay) {
        for (int i = operationDay.startingHour.hour;
            i < operationDay.endingHour.hour;
            i++) {
          currentCourtHourPrices.add(
            HourPrice(
              hour: Provider.of<DataProvider>(context, listen: false)
                  .availableHours
                  .firstWhere((hour) => hour.hour == i),
              weekday: operationDay.weekDay,
              price: 0,
            ),
          );
        }
      });
    }
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
            .idStoreCourt);
  }

  void deleteCourt(BuildContext context) {
    Provider.of<DataProvider>(context, listen: false)
        .courts
        .removeAt(selectedCourtIndex);
    selectedCourtIndex = -1;
    setFields(context);
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
