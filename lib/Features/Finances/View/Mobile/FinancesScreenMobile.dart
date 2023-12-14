import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Finances/View/Mobile/FinanceItem.dart';
import 'package:sandfriends_web/Features/Finances/ViewModel/FinancesViewModel.dart';
import 'package:sandfriends_web/Features/Rewards/View/Mobile/PlayerCalendarFilter.dart';
import 'package:sandfriends_web/SharedComponents/Model/EnumPeriodVisualization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/TypesExtensions.dart';
import '../../../../SharedComponents/View/SFPieChart.dart';
import '../../../../Utils/Constants.dart';
import '../../../Menu/View/Mobile/SFStandardHeader.dart';

class FinancesScreenMobile extends StatefulWidget {
  const FinancesScreenMobile({super.key});

  @override
  State<FinancesScreenMobile> createState() => FinancesScreenMobileState();
}

class FinancesScreenMobileState extends State<FinancesScreenMobile> {
  final FinancesViewModel viewModel = FinancesViewModel();
  final playerController = TextEditingController();
  bool isExpanded = false;

  @override
  void initState() {
    viewModel.initFinancesScreen(context);
    super.initState();
  }

  void expand() {
    setState(() {
      isExpanded = true;
    });
  }

  void collapse() {
    setState(() {
      isExpanded = false;
    });
  }

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FinancesViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<FinancesViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              children: [
                SFStandardHeader(
                  title: "Financeiro",
                  leftWidget: InkWell(
                    onTap: () => toggleExpand(),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        margin: const EdgeInsets.only(left: defaultPadding / 2),
                        child: SvgPicture.asset(
                          r"assets/icon/search.svg",
                          color: textWhite,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onVerticalDragUpdate: (drag) {
                          if (drag.delta.dy < -5.0) {
                            collapse();
                          } else if (drag.delta.dy > 5.0) {
                            expand();
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: double.infinity,
                          height: isExpanded ? 170 : 120,
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                defaultBorderRadius,
                              ),
                              bottomRight: Radius.circular(
                                defaultBorderRadius,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedSize(
                                        duration: Duration(milliseconds: 200),
                                        child: isExpanded
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: defaultPadding),
                                                child: PlayerCalendarFilter(
                                                  playerController:
                                                      playerController,
                                                  onSelectedPeriod:
                                                      (newPeriod) => viewModel
                                                          .setPeriodVisualization(
                                                              context,
                                                              newPeriod),
                                                  selectedPeriod: viewModel
                                                      .periodVisualization,
                                                ),
                                              )
                                            : Container()),
                                    Flexible(
                                      child: Text(
                                        viewModel.revenueTitle,
                                        style: TextStyle(
                                          color: textWhite,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Text(
                                            "R\$",
                                            style: TextStyle(
                                              color: textLightGrey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32,
                                            ),
                                          ),
                                          Text(
                                            viewModel.revenue
                                                .formatPrice(showRS: false),
                                            style: TextStyle(
                                              color: textWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 32,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              Container(
                                width: 50,
                                height: 4,
                                margin: EdgeInsets.symmetric(
                                    vertical: defaultPadding / 2),
                                decoration: BoxDecoration(
                                    color: secondaryPaper,
                                    borderRadius:
                                        BorderRadius.circular(defaultPadding)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: defaultPadding,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: secondaryPaper,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadius,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding,
                                    vertical: defaultPadding / 2),
                                height: 70,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          viewModel.expectedRevenueTitle,
                                          style: TextStyle(
                                            color: textDarkGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: defaultPadding / 2,
                                    ),
                                    Text(
                                      "R\$",
                                      style: TextStyle(
                                        color: textLightGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      viewModel.expectedRevenue
                                          .formatPrice(showRS: false),
                                      style: TextStyle(
                                        color: textBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: defaultPadding,
                              ),
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: secondaryPaper,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadius,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding,
                                    vertical: defaultPadding / 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Modalidade",
                                            style: TextStyle(
                                              color: textDarkGrey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: defaultPadding / 2,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: defaultBorderRadius,
                                                width: defaultBorderRadius,
                                                decoration: BoxDecoration(
                                                  color: primaryBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    4,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: defaultPadding / 2,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Mensalista (58%)",
                                                    style: TextStyle(
                                                      color: textDarkGrey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "R\$230,00",
                                                    style: TextStyle(
                                                      color: textLightGrey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: defaultPadding / 4,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: defaultBorderRadius,
                                                width: defaultBorderRadius,
                                                decoration: BoxDecoration(
                                                  color: secondaryLightBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    4,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: defaultPadding / 2,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Avulso (42%)",
                                                    style: TextStyle(
                                                      color: textDarkGrey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "R\$190,00",
                                                    style: TextStyle(
                                                      color: textLightGrey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    LayoutBuilder(builder:
                                        (layoutContext, layoutConstraints) {
                                      return SizedBox(
                                        height: layoutConstraints.maxHeight,
                                        width: layoutConstraints.maxHeight,
                                        child: SFPieChart(
                                          pieChartItems:
                                              viewModel.pieChartItems,
                                          showLabels: false,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: defaultPadding,
                              ),
                              Text(
                                "Partidas",
                                style: TextStyle(
                                  color: textDarkGrey,
                                ),
                              ),
                              SizedBox(
                                height: defaultPadding / 2,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: secondaryPaper,
                                    borderRadius: BorderRadius.circular(
                                      defaultBorderRadius,
                                    ),
                                  ),
                                  child: viewModel.matches.isEmpty
                                      ? Center(
                                          child: Text(
                                            "Sem partidas",
                                            style: TextStyle(
                                              color: textDarkGrey,
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: viewModel.matches.length,
                                          itemBuilder: (context, index) {
                                            return FinanceItem(
                                                match:
                                                    viewModel.matches[index]);
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
