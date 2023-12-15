import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Finances/Repository/FinancesRepoImp.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';
import 'package:intl/intl.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import '../../../Remote/NetworkResponse.dart';
import '../../../SharedComponents/Model/AppMatch.dart';
import '../../../SharedComponents/Model/EnumPeriodVisualization.dart';
import '../../../SharedComponents/Model/SFBarChartItem.dart';
import '../../../SharedComponents/View/DatePickerModal.dart';
import '../../../SharedComponents/View/SFPieChart.dart';
import '../../../Utils/SFDateTime.dart';
import 'package:provider/provider.dart';
import '../../Menu/ViewModel/DataProvider.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../Model/FinancesDataSource.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:collection/collection.dart';

class FinancesViewModel extends ChangeNotifier {
  final financesRepo = FinancesRepoImp();

  void initFinancesScreen(BuildContext context) {
    _matches = Provider.of<DataProvider>(context, listen: false)
        .matches
        .where((match) => match.blocked == false)
        .toList();
    setFinancesDataSource();
  }

  EnumPeriodVisualization periodVisualization = EnumPeriodVisualization.Today;
  void setPeriodVisualization(
      BuildContext context, EnumPeriodVisualization newPeriodVisualization) {
    if (newPeriodVisualization == EnumPeriodVisualization.Custom) {
      setCustomPeriod(context);
    } else {
      periodVisualization = newPeriodVisualization;
      setFinancesDataSource();
      notifyListeners();
    }
  }

  void setCustomPeriod(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false)
        .setModalForm(DatePickerModal(
      onDateSelected: (dateStart, dateEnd) {
        customStartDate = dateStart;
        customEndDate = dateEnd;
        searchCustomMatches(context);
      },
      onReturn: () =>
          Provider.of<MenuProvider>(context, listen: false).closeModal(),
    ));
  }

  void searchCustomMatches(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).setModalLoading();
    financesRepo
        .searchCustomMatches(
            context,
            Provider.of<DataProvider>(context, listen: false).loggedAccessToken,
            customStartDate!,
            customEndDate)
        .then((response) {
      if (response.responseStatus == NetworkResponseStatus.success) {
        Map<String, dynamic> responseBody = json.decode(
          response.responseBody!,
        );
        customMatches.clear();
        for (var match in responseBody['Matches']) {
          customMatches.add(
            AppMatch.fromJson(
              match,
              Provider.of<DataProvider>(context, listen: false).availableHours,
              Provider.of<DataProvider>(context, listen: false).availableSports,
            ),
          );
        }
        Provider.of<MenuProvider>(context, listen: false).closeModal();
        periodVisualization = EnumPeriodVisualization.Custom;
        setFinancesDataSource();
        notifyListeners();
      } else if (response.responseStatus ==
          NetworkResponseStatus.expiredToken) {
        Provider.of<MenuProvider>(context, listen: false).logout(context);
      } else {
        Provider.of<MenuProvider>(context, listen: false)
            .setMessageModalFromResponse(response);
      }
    });
  }

  List<AppMatch> _matches = [];
  List<AppMatch> customMatches = [];
  List<AppMatch> get matches {
    List<AppMatch> filteredMatches = [];
    if (periodVisualization == EnumPeriodVisualization.Today) {
      filteredMatches = _matches
          .where(
            (match) =>
                areInTheSameDay(match.date, DateTime.now()) &&
                match.matchCreatorName.toLowerCase().contains(
                      playerFilter,
                    ),
          )
          .toList();
    } else if (periodVisualization == EnumPeriodVisualization.CurrentMonth) {
      filteredMatches = _matches
          .where(
            (match) =>
                isInCurrentMonth(match.date) &&
                match.matchCreatorName.toLowerCase().contains(
                      playerFilter,
                    ),
          )
          .toList();
    } else {
      filteredMatches = customMatches
          .where(
            (match) => match.matchCreatorName.toLowerCase().contains(
                  playerFilter,
                ),
          )
          .toList();
    }
    filteredMatches.sort((a, b) => a.date.compareTo(b.date));
    return filteredMatches;
  }

  String playerFilter = "";
  void updatePlayerFilter(String text) {
    playerFilter = text;
    notifyListeners();
  }

  bool _showNetCost = false;
  bool get showNetCost => _showNetCost;
  void setShowNetCost(bool newValue) {
    _showNetCost = newValue;
    setFinancesDataSource();
    notifyListeners();
  }

  double get revenue {
    return matches.isEmpty
        ? 0
        : matches
            .where((match) => match.date.isBefore(DateTime.now()))
            .toList()
            .fold(0,
                (sum, item) => sum + (showNetCost ? item.netCost : item.cost));
  }

  String get revenueTitle {
    String titleDate;
    if (periodVisualization == EnumPeriodVisualization.Today) {
      titleDate = "no hoje";
    } else if (periodVisualization == EnumPeriodVisualization.CurrentMonth) {
      titleDate =
          "${monthsPortuguese[getSFMonthIndex(DateTime.now())]}/${DateTime.now().year}";
    } else {
      titleDate = customDateTitle!;
    }
    return "Faturamento $titleDate";
  }

  double get expectedRevenue {
    return matches.fold(
        0, (sum, item) => sum + (showNetCost ? item.netCost : item.cost));
  }

  String get expectedRevenueTitle {
    String titleDate;
    if (periodVisualization == EnumPeriodVisualization.Today) {
      titleDate = "final de dia";
    } else if (periodVisualization == EnumPeriodVisualization.CurrentMonth) {
      titleDate = "final do mês";
    } else {
      titleDate = customEndDate != null
          ? "até ${DateFormat('dd/MM').format(customEndDate!)}"
          : DateFormat('dd/MM').format(customStartDate!);
    }
    return "Previsão de faturamento $titleDate";
  }

  DateTime? customStartDate;
  DateTime? customEndDate;
  String? get customDateTitle {
    if (customStartDate != null) {
      if (customEndDate == null) {
        return DateFormat("dd/MM/yy").format(customStartDate!);
      } else {
        return "${DateFormat("dd/MM/yy").format(customStartDate!)} - ${DateFormat("dd/MM/yy").format(customEndDate!)}";
      }
    }
    return null;
  }

  List<SFBarChartItem> get barChartItems {
    List<SFBarChartItem> a = matches
        .map(
          (match) => SFBarChartItem(
            date: match.date,
            amount: (showNetCost ? match.netCost.toInt() : match.cost.toInt()),
          ),
        )
        .toList();

    return a;
  }

  double get revenueFromMatch {
    return matches.where((match) => !match.isFromRecurrentMatch).toList().fold(
        0,
        (previousValue, element) =>
            previousValue + (showNetCost ? element.netCost : element.cost));
  }

  double get revenueFromRecurrentMatch {
    return matches.where((match) => match.isFromRecurrentMatch).toList().fold(
        0,
        (previousValue, element) =>
            previousValue + (showNetCost ? element.netCost : element.cost));
  }

  int get revenueFromMatchPercentage {
    return expectedRevenue == 0
        ? 0
        : (revenueFromMatch * 100) ~/ expectedRevenue;
  }

  int get revenueFromRecurrentMatchPercentage {
    return expectedRevenue == 0
        ? 0
        : (revenueFromRecurrentMatch * 100) ~/ expectedRevenue;
  }

  //////// TABLE ////////////////////////////////////////
  FinancesDataSource? financesDataSource;

  void setFinancesDataSource() {
    financesDataSource =
        FinancesDataSource(matches: matches, showNetValue: showNetCost);
  }
  ///////////////////////////////////////////////////////

  /////////// PIE CHART ////////////////////////////////////
  List<PieChartItem> get pieChartItems {
    List<PieChartItem> items = [];
    Map<String, int> nameCount = <String, int>{};
    nameCount["Mensalista"] = revenueFromRecurrentMatch.toInt();
    nameCount["Avulso"] = revenueFromMatch.toInt();

    nameCount.forEach((key, value) {
      if (value > 0) {
        items.add(
          PieChartItem(
            name: key,
            value: value.toDouble(),
            prefix: "R\$",
            color: key == "Mensalista" ? primaryLightBlue : primaryBlue,
          ),
        );
      }
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
