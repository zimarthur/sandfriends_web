import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Finances/View/FinanceKpi.dart';
import 'package:sandfriends_web/Features/Finances/ViewModel/FinancesViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import '../../../SharedComponents/View/SFCard.dart';
import '../../../SharedComponents/View/SFHeader.dart';
import '../../../SharedComponents/View/SFPieChart.dart';
import '../../../SharedComponents/View/SFToggle.dart';
import '../../../SharedComponents/View/Table/SFTable.dart';
import '../../../SharedComponents/View/Table/SFTableHeader.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final FinancesViewModel viewModel = FinancesViewModel();

  @override
  void initState() {
    viewModel.setFinancesDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
    return ChangeNotifierProvider<FinancesViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<FinancesViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SFHeader(
                  header: "Finanças",
                  description:
                      "Confira o faturamento de suas quadras atual e para os próximos dias"),
              SizedBox(
                height: height * 0.01,
              ),
              SFToggle(
                const ["Hoje", "Esse mês", "Histórico"],
                viewModel.selectedFilterIndex,
                (value) {
                  viewModel.selectedFilterIndex = value;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: LayoutBuilder(builder: (buildContext, boxConstrains) {
                  double dashboardHeight = boxConstrains.maxHeight;
                  double firstRowHeight = dashboardHeight * 0.9;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * 0.4,
                              height: firstRowHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FinanceKpi(
                                    title:
                                        "Faturamento ${viewModel.selectedFilterIndex == 0 ? DateFormat('dd/MM').format(viewModel.matches.first.date) : viewModel.selectedFilterIndex == 1 ? monthsPortuguese[viewModel.matches.first.date.month] + "/" + DateFormat('yy').format(viewModel.matches.first.date) : "geral"}",
                                    value: "R\$ ${viewModel.getRevenue()},00",
                                    iconPath: r"assets/icon/money.svg",
                                    iconColor: success,
                                    iconColorBackground: success50,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  FinanceKpi(
                                    title:
                                        "Previsão ${viewModel.selectedFilterIndex == 0 ? "final do dia" : viewModel.selectedFilterIndex == 1 ? "final do mês" : "geral"}",
                                    value:
                                        "R\$ ${viewModel.getExpectedRevenue()},00",
                                    iconPath: r"assets/icon/forecast.svg",
                                    iconColor: forecast,
                                    iconColorBackground: forecast50,
                                  ),
                                  const SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Expanded(
                                    child: LayoutBuilder(builder:
                                        (cardContext, cardConstraints) {
                                      return SFCard(
                                        height: cardConstraints.maxHeight,
                                        width: width * 0.4,
                                        title: "Faturamento por modalidade",
                                        child: SFPieChart(
                                          pieChartItems:
                                              viewModel.pieChartItems,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            SFTable(
                              height: firstRowHeight,
                              width: width * 0.6 - defaultPadding,
                              headers: [
                                SFTableHeader("date", "Data"),
                                SFTableHeader("hour", "Hora"),
                                SFTableHeader("court", "Quadra"),
                                SFTableHeader("price", "Preço"),
                                SFTableHeader("player", "Jogador"),
                                SFTableHeader("sport", "Esporte"),
                              ],
                              source: viewModel.financesDataSource!,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        SFCard(
                          height: dashboardHeight * 0.6,
                          width: width,
                          title: "Faturamento por data",
                          child: BarChart(
                            viewModel.barChartData,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}