import 'package:flutter/cupertino.dart';
import 'package:sandfriends_web/Dashboard/Features/Rewards/Model/Reward.dart';
import 'package:sandfriends_web/Dashboard/Features/Rewards/Model/RewardDataSource.dart';
import 'package:sandfriends_web/Dashboard/Features/Rewards/View/AddRewardWidget.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DashboardViewModel.dart';
import 'package:sandfriends_web/SharedComponents/Model/Player.dart';
import 'package:sandfriends_web/SharedComponents/View/SFPieChart.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class RewardsViewModel extends ChangeNotifier {
  int _selectedFilterIndex = 0;
  int get selectedFilterIndex => _selectedFilterIndex;
  set selectedFilterIndex(int index) {
    _selectedFilterIndex = index;
    setRewardDataSource();
    notifyListeners();
  }

  void returnMainView(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).closeModal();
  }

  int get rewardsCounter => rewards.length;

  final List<Reward> _rewards = [
    Reward(reward: "Agua", date: DateTime.now(), player: arthur),
    Reward(
        reward: "Agua",
        date: DateTime.now().subtract(const Duration(days: 5)),
        player: pietro),
    Reward(
        reward: "Gatorade",
        date: DateTime.now().subtract(const Duration(days: 15)),
        player: arthur),
    Reward(
        reward: "Bolinha",
        date: DateTime.now().subtract(const Duration(days: 20)),
        player: pietro),
    Reward(
        reward: "Agua",
        date: DateTime.now().subtract(const Duration(days: 50)),
        player: arthur),
  ];
  List<Reward> get rewards {
    if (selectedFilterIndex == 0) {
      return _rewards
          .where((element) => isSameDate(element.date, DateTime.now()))
          .toList();
    } else if (selectedFilterIndex == 1) {
      return _rewards
          .where((element) => isInCurrentMonth(element.date))
          .toList();
    } else {
      return _rewards;
    }
  }

  /////////////ADD REWARD //////////////////////////////
  void addReward(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      AddRewardWidget(context),
    );
  }

  TextEditingController addRewardController = TextEditingController();

  void validateAddReward(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).closeModal();
  }

  ///////////////////////////////////////////////////////

  //////// TABLE ////////////////////////////////////////
  RewardsDataSource? rewardsDataSource;

  void setRewardDataSource() {
    rewardsDataSource = RewardsDataSource(rewards: rewards);
  }
  ///////////////////////////////////////////////////////

  //////// PIE CHART ////////////////////////////////////
  List<PieChartItem> get pieChartItems {
    List<PieChartItem> items = [];
    Map<String, int> nameCount = <String, int>{};
    for (var object in rewards) {
      if (nameCount.containsKey(object.reward)) {
        nameCount[object.reward] = nameCount[object.reward]! + 1;
      } else {
        nameCount[object.reward] = 1;
      }
    }
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

  //////// BAR CHART ////////////////////////////////////

  Widget bottomTitles(double value, TitleMeta meta) {
    final Widget text = Transform.rotate(
      angle: -math.pi / 3,
      child: Text(
        selectedFilterIndex == 0
            ? '$value\n'
            : selectedFilterIndex == 1
                ? '$value\n'
                : '${getMonthYear(
                        DateTime.parse(monthsOnChartData[value.toInt()]))}\n',
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
                  : '${getMonthYear(DateTime.parse(monthsOnChartData[group.x]))}\n',
          const TextStyle(
            color: textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          children: <TextSpan>[
            TextSpan(
              text: (rod.toY).toString(),
              style: const TextStyle(
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
          int rewardsCounter = 0;
          for (var element in rewards) {
            if (isSameDate(element.date, DateTime.now()) &&
                element.date.hour == hourIndex) {
              rewardsCounter++;
            }
          }
          chartData.add(
            BarChartGroupData(
              x: hourIndex,
              barRods: [
                BarChartRodData(
                  toY: rewardsCounter.toDouble(),
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
          int rewardsCounter = 0;
          for (var element in rewards) {
            if (isSameDate(
                element.date,
                DateTime(
                    DateTime.now().year, DateTime.now().month, dayIndex))) {
              rewardsCounter++;
            }
          }
          chartData.add(
            BarChartGroupData(
              x: dayIndex,
              barRods: [
                BarChartRodData(
                  toY: rewardsCounter.toDouble(),
                  width: 15,
                  color: primaryBlue,
                ),
              ],
            ),
          );
        }
        break;
      case 2:
        rewards.sort((a, b) => b.date.compareTo(a.date));

        final groupByMonth = groupBy(rewards,
            (Reward reward) => DateTime(reward.date.year, reward.date.month));
        final rewardsByMonth = groupByMonth.map((key, value) => MapEntry(
            key, value.fold(0, (previousValue, element) => previousValue + 1)));

        rewardsByMonth.forEach((key, value) {
          chartData.add(
            BarChartGroupData(
              x: rewardsByMonth.keys.toList().indexOf(key),
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

Player arthur = Player(
    idUser: 1,
    firstName: "Arthur",
    lastName: "Zim",
    phoneNumber: "99",
    photo: "img");
Player pietro = Player(
    idUser: 1,
    firstName: "Pietro",
    lastName: "Berger",
    phoneNumber: "99",
    photo: "img");
