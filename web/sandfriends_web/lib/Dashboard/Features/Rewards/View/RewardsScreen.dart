import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/player.dart';
import 'package:sandfriends_web/SharedComponents/View/SFPieChart.dart';
import 'package:sandfriends_web/SharedComponents/View/Table/SFTable.dart';
import 'package:sandfriends_web/SharedComponents/View/Table/SFTableHeader.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFCard.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFToggle.dart';
import '../../../../Utils/Constants.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import '../Model/Reward.dart';
import '../Model/RewardDataSource.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../ViewModel/RewardsViewModel.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final RewardsViewModel viewModel = RewardsViewModel();

  @override
  void initState() {
    viewModel.setRewardDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return ChangeNotifierProvider<RewardsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<RewardsViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: SFHeader(
                        header: "Recompensas",
                        description:
                            "Confira as recompensas que os jogadores já retiraram no seu estabelecimento!"),
                  ),
                  SFButton(
                    buttonLabel: "Adic. Recompensa",
                    buttonType: ButtonType.Primary,
                    onTap: () {
                      viewModel.addReward(context);
                    },
                    iconFirst: true,
                    iconPath: r"assets/icon/plus.svg",
                    textPadding: const EdgeInsets.symmetric(
                      vertical: defaultPadding,
                      horizontal: defaultPadding * 2,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SFToggle(
                ["Hoje", "Esse mês", "Histórico"],
                viewModel.selectedFilterIndex,
                (value) {
                  viewModel.selectedFilterIndex = value;
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: 60,
                constraints: BoxConstraints(minHeight: 60),
                child: Row(
                  children: [
                    Text(
                      "Recompensas recolhidas:",
                      style: TextStyle(color: textDarkGrey),
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "${viewModel.rewardsCounter}",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                          color: textBlue, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double remainingHeight = height - 200;
                    final double widgetHeight =
                        constraints.maxHeight < remainingHeight
                            ? constraints.maxHeight
                            : remainingHeight;
                    return Container(
                      height: widgetHeight,
                      child: Row(
                        children: [
                          SFTable(
                            height: widgetHeight,
                            width: width * 0.5,
                            headers: [
                              SFTableHeader("date", "Data"),
                              SFTableHeader("hour", "Hora"),
                              SFTableHeader("player", "Jogador"),
                              SFTableHeader("reward", "Recompensa"),
                            ],
                            source: viewModel.rewardsDataSource!,
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Column(
                            children: [
                              SFCard(
                                height: (widgetHeight - defaultPadding) / 2,
                                width: width * 0.5 - defaultPadding,
                                title: "Recompensas mais recolhidas",
                                child: SFPieChart(
                                  pieChartItems: viewModel.pieChartItems,
                                ),
                              ),
                              SizedBox(
                                height: defaultPadding,
                              ),
                              SFCard(
                                height: (widgetHeight - defaultPadding) / 2,
                                width: width * 0.5 - defaultPadding,
                                title: "Recompensas recolhidas por data",
                                child: BarChart(
                                  viewModel.barChartData,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
