import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/SFCalendarWeek.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/CourtDay/CourtDay.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/MyCourtsTabSelector.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFTabs.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../ViewModel/DataProvider.dart';
import 'CourtInfo.dart';

class MyCourtsScreen extends StatefulWidget {
  const MyCourtsScreen({super.key});

  @override
  State<MyCourtsScreen> createState() => _MyCourtsScreenState();
}

class _MyCourtsScreenState extends State<MyCourtsScreen> {
  final MyCourtsViewModel viewModel = MyCourtsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.setFields(context);
  }

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    double courtInfoWidth = width * 0.3 < 300 ? 300 : width * 0.3;
    double courtWeekdayWidth = width -
        courtInfoWidth -
        5 * defaultPadding -
        4; // o 4 foi por causa da borda

    return ChangeNotifierProvider<MyCourtsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<MyCourtsViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: SFHeader(
                        header: "Minhas quadras",
                        description:
                            "Configure as quadras do seu estabelecimento!",
                      ),
                    ),
                    SFButton(
                      buttonLabel: "Horário de funcionamento",
                      buttonType: ButtonType.Secondary,
                      iconFirst: true,
                      iconPath: r"assets/icon/clock.svg",
                      onTap: () {
                        viewModel.setWorkingHours(context);
                      },
                      textPadding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: divider,
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          MyCourtsTabSelector(
                            title: "Adicionar Quadra",
                            isSelected: viewModel.selectedCourtIndex == -1
                                ? true
                                : false,
                            iconPath: r'assets/icon/plus.svg',
                            onTap: () {
                              viewModel.switchTabs(context, -1);
                            },
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: Provider.of<DataProvider>(context)
                                  .courts
                                  .length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return MyCourtsTabSelector(
                                  title: Provider.of<DataProvider>(context)
                                      .courts[index]
                                      .description,
                                  isSelected:
                                      viewModel.selectedCourtIndex == index
                                          ? true
                                          : false,
                                  onTap: () {
                                    viewModel.switchTabs(context, index);
                                  },
                                );
                              },
                            ),
                          ),
                          if (viewModel.courtInfoChanged)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: defaultPadding / 4),
                              child: SFButton(
                                buttonLabel: "Salvar",
                                buttonType: ButtonType.Primary,
                                textPadding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                onTap: () {},
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: divider,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(defaultBorderRadius),
                        bottomRight: Radius.circular(defaultBorderRadius),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 2, left: 2, right: 2),
                      padding: EdgeInsets.all(2 * defaultPadding),
                      decoration: BoxDecoration(
                        color: secondaryPaper,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultBorderRadius),
                          bottomRight: Radius.circular(defaultBorderRadius),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: courtInfoWidth,
                            height: height,
                            child: CourtInfo(
                              viewModel: viewModel,
                              newCourt: viewModel.isNewCourt,
                            ),
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (ctx, cnst) {
                                double myHeight = (cnst.maxHeight -
                                                6 * defaultPadding) /
                                            8 >
                                        50
                                    ? (cnst.maxHeight - 6 * defaultPadding) / 8
                                    : 50;
                                return Column(
                                  children: [
                                    Container(
                                      height: myHeight,
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.only(right: 50),
                                      width: courtWeekdayWidth,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Dia",
                                              style: TextStyle(
                                                  color: textLightGrey),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Horário",
                                              style: TextStyle(
                                                  color: textLightGrey),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Aceita\nMensalista?",
                                              style: TextStyle(
                                                  color: textLightGrey),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "Preço\n(Mensalista)",
                                              style: TextStyle(
                                                  color: textLightGrey),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 7,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              CourtDay(
                                                width: courtWeekdayWidth,
                                                height: myHeight,
                                              ),
                                              if (index != 6)
                                                SizedBox(
                                                  height: defaultPadding,
                                                )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
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
