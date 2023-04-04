import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Hour.dart';
import 'package:sandfriends_web/SharedComponents/Model/Match.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Sport.dart';
import 'package:intl/intl.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import '../../../../SharedComponents/View/SFPieChart.dart';
import '../../../../Utils/SFDateTime.dart';
import '../Model/FinancesDataSource.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;
import 'package:collection/collection.dart';

class FinancesViewModel extends ChangeNotifier {
  int _selectedFilterIndex = 0;
  int get selectedFilterIndex => _selectedFilterIndex;
  set selectedFilterIndex(int index) {
    _selectedFilterIndex = index;
    setFinancesDataSource();
    notifyListeners();
  }

  List<Match> _matches = [
    Match(
      idMatch: 1,
      date: DateFormat('yyyy-MM-dd HH:mm').parse("2023-04-03 15:00"),
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
      date: DateFormat('yyyy-MM-dd HH:mm').parse("2023-04-03 23:00"),
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
      date: DateFormat('yyyy-MM-dd HH:mm').parse("2023-03-03 15:00"),
      cost: 70,
      openUsers: false,
      maxUsers: 4,
      canceled: false,
      creationDate: DateTime.now(),
      matchUrl: "matchUrl",
      creatorNotes: "creatorNotes",
      idRecurrentMatch: 1,
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

  int getRevenue() {
    List<Match> currentMatches =
        matches.where((match) => match.date.isBefore(DateTime.now())).toList();
    return currentMatches.fold(0, (sum, item) => sum + item.cost);
  }

  int getExpectedRevenue() {
    return matches.fold(0, (sum, item) => sum + item.cost);
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
    Map<String, int> nameCount = LinkedHashMap<String, int>();
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

  //////// BAR CHART ////////////////////////////////////

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Transform.rotate(
      angle: -math.pi / 3,
      child: Text(
        selectedFilterIndex == 0
            ? '${value}\n'
            : selectedFilterIndex == 1
                ? '${value}\n'
                : getMonthYear(
                        DateTime.parse(monthsOnChartData[value.toInt()])) +
                    '\n',
        style: const TextStyle(
          color: textDarkGrey,
        ),
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  List<String> monthsOnChartData = [];
  BarChartData get barChartData {
    List<BarChartGroupData> chartData = [];
    BarTouchTooltipData barTouchTooltipData = BarTouchTooltipData(
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        return BarTooltipItem(
          selectedFilterIndex == 0
              ? '${group.x}:00\n'
              : selectedFilterIndex == 1
                  ? 'Dia ${group.x}\n'
                  : getMonthYear(DateTime.parse(monthsOnChartData[group.x])) +
                      '\n',
          const TextStyle(
            color: textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "R\$ ${(rod.toY).toString()}",
              style: TextStyle(
                color: primaryLightBlue,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );

    switch (selectedFilterIndex) {
      case 0:
        for (int hourIndex = 1; hourIndex < 25; hourIndex++) {
          int revenue = 0;
          for (var match in matches) {
            if (isSameDate(match.date, DateTime.now()) &&
                match.date.hour == hourIndex) {
              revenue = revenue + match.cost;
            }
          }
          chartData.add(
            BarChartGroupData(
              x: hourIndex,
              barRods: [
                BarChartRodData(
                  toY: revenue.toDouble(),
                  width: 15,
                  color: primaryBlue,
                ),
              ],
            ),
          );
        }
        break;
      case 1:
        for (int dayIndex = 1;
            dayIndex < lastDayOfMonth(DateTime.now()).day;
            dayIndex++) {
          int revenue = 0;
          for (var match in matches) {
            if (isSameDate(
                match.date,
                new DateTime(
                    DateTime.now().year, DateTime.now().month, dayIndex))) {
              revenue = revenue + match.cost;
            }
          }
          chartData.add(
            BarChartGroupData(
              x: dayIndex,
              barRods: [
                BarChartRodData(
                  toY: revenue.toDouble(),
                  width: 15,
                  color: primaryBlue,
                ),
              ],
            ),
          );
        }
        break;
      case 2:
        matches.sort((a, b) => b.date.compareTo(a.date));

        final groupByMonth = groupBy(matches,
            (Match match) => DateTime(match.date.year, match.date.month));
        final matchesByMonth = groupByMonth.map((key, value) => MapEntry(
            key,
            value.fold(
                0, (previousValue, element) => previousValue + element.cost)));

        matchesByMonth.forEach((key, value) {
          chartData.add(
            BarChartGroupData(
              x: matchesByMonth.keys.toList().indexOf(key),
              showingTooltipIndicators: [1],
              barRods: [
                BarChartRodData(
                  toY: value.toDouble(),
                  width: 15,
                  color: primaryBlue,
                ),
              ],
            ),
          );
          monthsOnChartData.add(key.toString());
        });
        break;
    }
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: barTouchTooltipData,
      ),
      titlesData: FlTitlesData(
        show: true,
        // Add your x axis labels here
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitles,
            reservedSize: 42,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
          border: const Border(
        top: BorderSide.none,
        right: BorderSide.none,
        left: BorderSide.none,
        bottom: BorderSide(width: 1),
      )),
      groupsSpace: 10,
      barGroups: chartData,
    );
  }

///////////////////////////////////////////////////////
}
