import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/WorkingHoursWidget.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AvailableSport.dart';

import '../../../../SharedComponents/Model/Court.dart';
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

  int _selectedCourtIndex = -1;
  int get selectedCourtIndex => _selectedCourtIndex;
  set selectedCourtIndex(int value) {
    _selectedCourtIndex = value;
    notifyListeners();
  }

  List<AvailableSport> sports = [];

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
}
