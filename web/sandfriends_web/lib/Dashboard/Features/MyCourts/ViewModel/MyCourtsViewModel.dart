import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/WorkingHoursWidget.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';

import '../../../../SharedComponents/Model/Court.dart';
import '../../../../SharedComponents/Model/Hour.dart';
import '../../../ViewModel/DashboardViewModel.dart';

class MyCourtsViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  bool _isNewCourt = true;
  bool get isNewCourt => _isNewCourt;
  set isNewCourt(bool value) {
    _isNewCourt = value;
    notifyListeners();
  }

  bool _isIndoor = true;
  bool get isIndoor => _isIndoor;
  set isIndoor(bool value) {
    _isIndoor = value;
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

  List<AvailableSport> sports = [];

  List<OperationDay> operationDays = [
    OperationDay(
      weekDay: 0,
      startingHour: Hour(hour: 8, hourString: "08:00"),
      endingHour: Hour(hour: 22, hourString: "22:00"),
    ),
    OperationDay(
      weekDay: 1,
      startingHour: Hour(hour: 8, hourString: "08:00"),
      endingHour: Hour(hour: 22, hourString: "22:00"),
    ),
    OperationDay(
      weekDay: 2,
      startingHour: Hour(hour: 8, hourString: "08:00"),
      endingHour: Hour(hour: 22, hourString: "22:00"),
    ),
    OperationDay(
      weekDay: 3,
      startingHour: Hour(hour: 8, hourString: "08:00"),
      endingHour: Hour(hour: 22, hourString: "22:00"),
    ),
    OperationDay(
      weekDay: 4,
      startingHour: Hour(hour: 8, hourString: "08:00"),
      endingHour: Hour(hour: 22, hourString: "22:00"),
    ),
    OperationDay(
      weekDay: 5,
      startingHour: Hour(hour: 8, hourString: "08:00"),
      endingHour: Hour(hour: 22, hourString: "22:00"),
    ),
    OperationDay(
      weekDay: 6,
      startingHour: Hour(hour: 8, hourString: "08:00"),
      endingHour: Hour(hour: 22, hourString: "22:00"),
    ),
  ];

  void setWorkingHours(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      WorkingHoursWidget(),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalSuccess();
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
      isIndoor = true;
      sports.clear();
      Provider.of<DataProvider>(context, listen: false).sports.forEach((sport) {
        sports.add(
          AvailableSport(
            sport: sport,
            isAvailable: false,
          ),
        );
      });
    } else {
      Court referenceCourt = Provider.of<DataProvider>(context, listen: false)
          .courts[selectedCourtIndex];
      nameController.text = referenceCourt.description;
      isIndoor = referenceCourt.isIndoor;
      sports.clear();
      referenceCourt.sports.forEach(
        (availableSport) {
          sports.add(availableSport);
        },
      );
    }
  }

  void addCourt(BuildContext context) {
    if (nameController.text.isEmpty) print("sem nome");

    if (Provider.of<DataProvider>(context, listen: false)
        .courts
        .any((element) => element.description == nameController.text))
      print("nome já existe");

    if (sports.any((element) => element.isAvailable == true) == false)
      print("selecione esporte");

    //VAI TER Q ALTERAR PRA RECEBER O ID DO SERVIDOR
    var newCourt = Court(
        idStoreCourt:
            Provider.of<DataProvider>(context, listen: false).courts.length,
        description: nameController.text,
        isIndoor: isIndoor);
    sports.forEach((sport) {
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
      sports.forEach((formSport) {
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
          isIndoor !=
              Provider.of<DataProvider>(context, listen: false)
                  .courts[selectedCourtIndex]
                  .isIndoor ||
          changedSport;
    }
  }
}
