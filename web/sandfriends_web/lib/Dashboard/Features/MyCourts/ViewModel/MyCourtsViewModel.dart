import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/WorkingHoursWidget.dart';

import '../../../ViewModel/DashboardViewModel.dart';

class MyCourtsViewModel extends ChangeNotifier {
  void setWorkingHours(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      WorkingHoursWidget(),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalSuccess();
  }
}
