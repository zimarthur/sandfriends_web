import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/Match.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';

import '../../../../SharedComponents/View/SFPieChart.dart';
import '../../../../Utils/SFDateTime.dart';
import '../Model/FinancesDataSource.dart';

class FinancesViewModel extends ChangeNotifier {
  int _selectedFilterIndex = 0;
  int get selectedFilterIndex => _selectedFilterIndex;
  set selectedFilterIndex(int index) {
    _selectedFilterIndex = index;
    notifyListeners();
  }

  List<Match> _matches = [
    Match(
      idMatch: 1,
      date: DateTime.now(),
      cost: 100,
      openUsers: false,
      maxUsers: 4,
      canceled: false,
      creationDate: DateTime.now(),
      matchUrl: "matchUrl",
      creatorNotes: "creatorNotes",
      idRecurrentMatch: null,
      idStoreCOurt: 1,
      sport: Sport(
          idSport: 1, description: "Beach tenis", sportPhoto: "sportPhoto"),
      startingHour: Hour(hour: 9, hourString: "09:00"),
      endingHour: Hour(hour: 10, hourString: "10:00"),
      membersUserIds: [],
    ),
    Match(
      idMatch: 1,
      date: DateTime.now().subtract(Duration(days: 5)),
      cost: 90,
      openUsers: false,
      maxUsers: 4,
      canceled: false,
      creationDate: DateTime.now(),
      matchUrl: "matchUrl",
      creatorNotes: "creatorNotes",
      idRecurrentMatch: null,
      idStoreCOurt: 1,
      sport: Sport(
          idSport: 1, description: "Beach tenis", sportPhoto: "sportPhoto"),
      startingHour: Hour(hour: 9, hourString: "09:00"),
      endingHour: Hour(hour: 10, hourString: "10:00"),
      membersUserIds: [],
    ),
    Match(
      idMatch: 1,
      date: DateTime.now().subtract(Duration(days: 31)),
      cost: 70,
      openUsers: false,
      maxUsers: 4,
      canceled: false,
      creationDate: DateTime.now(),
      matchUrl: "matchUrl",
      creatorNotes: "creatorNotes",
      idRecurrentMatch: null,
      idStoreCOurt: 1,
      sport: Sport(
          idSport: 1, description: "Beach tenis", sportPhoto: "sportPhoto"),
      startingHour: Hour(hour: 9, hourString: "09:00"),
      endingHour: Hour(hour: 10, hourString: "10:00"),
      membersUserIds: [],
    ),
  ];
  List<Match> get matches {
    if (selectedFilterIndex == 0) {
      return _matches
          .where((element) => isSameDate(element.date, DateTime.now()))
          .toList();
    } else if (selectedFilterIndex == 1) {
      return _matches
          .where((element) => isInCurrentMonth(element.date))
          .toList();
    } else {
      return _matches;
    }
  }

  //////// TABLE ////////////////////////////////////////
  FinancesDataSource? financesDataSource;

  void setRewardDataSource() {
    financesDataSource = FinancesDataSource(matches: matches);
  }
  ///////////////////////////////////////////////////////

  /////////// PIE CHART ////////////////////////////////////
  List<PieChartItem> get pieChartItems {
    List<PieChartItem> items = [];
    Map<String, int> nameCount = LinkedHashMap<String, int>();
    nameCount["Mensalista"] = 0;
    nameCount["Avulso"] = 0;
    matches.forEach((match) {
      if (match.idRecurrentMatch != null) {
        nameCount["Mensalista"] = nameCount["Mensalista"]! + 1;
      } else {
        nameCount["Avulso"] = nameCount["Avulso"]! + 1;
      }
    });
    nameCount.forEach((key, value) {
      items.add(PieChartItem(name: key, value: value.toDouble()));
    });
    if (hoveredItem >= 0) {
      PieChartItem auxItem;
      auxItem = items[0];
      items[0] = items[hoveredItem];
      items[hoveredItem] = auxItem;
    }
    return items;
  }

  int _hoveredItem = -1;
  int get hoveredItem => _hoveredItem;
  set hoveredItem(int value) {
    _hoveredItem = value;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////
}
