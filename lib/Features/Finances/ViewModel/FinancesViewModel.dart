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
    print("setPeriodVisualization START ${DateTime.now()}");
    if (newPeriodVisualization == EnumPeriodVisualization.Custom) {
      setCustomPeriod(context);
    } else {
      periodVisualization = newPeriodVisualization;
      setFinancesDataSource();
      notifyListeners();
    }
    print("setPeriodVisualization END ${DateTime.now()}");
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
          .where((element) => areInTheSameDay(element.date, DateTime.now()))
          .toList();
    } else if (periodVisualization == EnumPeriodVisualization.CurrentMonth) {
      filteredMatches =
          _matches.where((element) => isInCurrentMonth(element.date)).toList();
    } else {
      filteredMatches = customMatches;
    }
    filteredMatches.sort((a, b) => a.date.compareTo(b.date));
    return filteredMatches;
  }

  int get revenue {
    return matches.isEmpty
        ? 0
        : matches
            .where((match) => match.date.isBefore(DateTime.now()))
            .toList()
            .fold(0, (sum, item) => sum + item.cost);
  }

  String get revenueTitle {
    String titleDate;
    if (periodVisualization == EnumPeriodVisualization.Today) {
      titleDate = DateFormat('dd/MM').format(DateTime.now());
    } else if (periodVisualization == EnumPeriodVisualization.CurrentMonth) {
      titleDate =
          "${monthsPortuguese[DateTime.now().month]}/${DateTime.now().year}";
    } else {
      titleDate = customDateTitle!;
    }
    return "Faturamento $titleDate";
  }

  int get expectedRevenue {
    return matches.fold(0, (sum, item) => sum + item.cost);
  }

  String get expectedRevenueTitle {
    String titleDate;
    if (periodVisualization == EnumPeriodVisualization.Today) {
      titleDate = "de hoje";
    } else if (periodVisualization == EnumPeriodVisualization.CurrentMonth) {
      titleDate = "do mês";
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
            amount: match.cost,
          ),
        )
        .toList();

    return a;
  }

  //////// TABLE ////////////////////////////////////////
  FinancesDataSource? financesDataSource;

  void setFinancesDataSource() {
    financesDataSource = FinancesDataSource(matches: matches);
  }
  ///////////////////////////////////////////////////////

  /////////// PIE CHART ////////////////////////////////////
  List<PieChartItem> get pieChartItems {
    List<PieChartItem> items = [];
    Map<String, int> nameCount = <String, int>{};
    nameCount["Mensalista"] = 0;
    nameCount["Avulso"] = 0;
    for (var match in matches) {
      if (match.idRecurrentMatch != null) {
        nameCount["Mensalista"] = nameCount["Mensalista"]! + match.cost;
      } else {
        nameCount["Avulso"] = nameCount["Avulso"]! + match.cost;
      }
    }
    nameCount.forEach((key, value) {
      if (value > 0) {
        items.add(
            PieChartItem(name: key, value: value.toDouble(), prefix: "R\$"));
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
