import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/Finances/View/FinanceKpi.dart';
import 'package:sandfriends_web/Dashboard/Features/Finances/ViewModel/FinancesViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFCard.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFPieChart.dart';
import '../../../../SharedComponents/View/SFToggle.dart';
import '../../../../SharedComponents/View/Table/SFTable.dart';
import '../../../../SharedComponents/View/Table/SFTableHeader.dart';
import '../../../ViewModel/DashboardViewModel.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final FinancesViewModel viewModel = FinancesViewModel();

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
    return ChangeNotifierProvider<FinancesViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<FinancesViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SFHeader(
                  header: "Finanças",
                  description:
                      "Confira o faturamento de suas quadras atual e para os próximos dias"),
              SizedBox(
                height: height * 0.01,
              ),
              SFToggle(
                ["Hoje", "Esse mês", "Histórico"],
                viewModel.selectedFilterIndex,
                (value) {
                  viewModel.selectedFilterIndex = value;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FinanceKpi(
                                  title: "Faturamento",
                                  value: "R\$ 14.512,00",
                                  iconPath: r"assets/icon/money.svg",
                                  iconColor: success,
                                  iconColorBackground: success50,
                                ),
                                SizedBox(
                                  height: defaultPadding,
                                ),
                                FinanceKpi(
                                  title: "Previsão final do dia",
                                  value: "R\$ 18.512,00",
                                  iconPath: r"assets/icon/forecast.svg",
                                  iconColor: forecast,
                                  iconColorBackground: forecast50,
                                ),
                                SFCard(
                                  height: 200,
                                  width: width * 0.35,
                                  title: "Faturamento por modalidade",
                                  child: SFPieChart(
                                    pieChartItems: viewModel.pieChartItems,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          SFTable(
                            height: height,
                            width: width * 0.65 - defaultPadding,
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
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
