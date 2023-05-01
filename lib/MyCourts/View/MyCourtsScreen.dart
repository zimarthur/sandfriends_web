import 'package:flutter/material.dart';
import 'package:sandfriends_web/MyCourts/View/CourtDay/CourtDay.dart';
import 'package:sandfriends_web/MyCourts/View/CourtDay/ResumedInfoRowHeader.dart';
import 'package:sandfriends_web/MyCourts/View/MyCourtsTabSelector.dart';
import 'package:sandfriends_web/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../SharedComponents/View/SFButton.dart';
import '../../SharedComponents/View/SFHeader.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Menu/ViewModel/DataProvider.dart';
import 'CourtInfo.dart';

class MyCourtsScreen extends StatefulWidget {
  bool? showWorkingHours;
  MyCourtsScreen({super.key, this.showWorkingHours = false});

  @override
  State<MyCourtsScreen> createState() => _MyCourtsScreenState();
}

class _MyCourtsScreenState extends State<MyCourtsScreen> {
  final MyCourtsViewModel viewModel = MyCourtsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showWorkingHours == true) {
        setState(() {
          viewModel.setWorkingHoursWidget(context, viewModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
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
                        viewModel.setWorkingHoursWidget(context, viewModel);
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
                            mouseCursor: Provider.of<DataProvider>(context)
                                    .operationDays
                                    .isEmpty
                                ? SystemMouseCursors.basic
                                : SystemMouseCursors.click,
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
                                    setState(() {
                                      viewModel.switchTabs(context, index);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          if (viewModel.courtInfoChanged)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 4),
                              child: SFButton(
                                buttonLabel: "Salvar",
                                buttonType: ButtonType.Primary,
                                textPadding: const EdgeInsets.symmetric(
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
                    decoration: const BoxDecoration(
                      color: divider,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(defaultBorderRadius),
                        bottomRight: Radius.circular(defaultBorderRadius),
                      ),
                    ),
                    child: Container(
                      margin:
                          const EdgeInsets.only(bottom: 2, left: 2, right: 2),
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: const BoxDecoration(
                        color: secondaryPaper,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(defaultBorderRadius),
                          bottomRight: Radius.circular(defaultBorderRadius),
                        ),
                      ),
                      child: Provider.of<DataProvider>(context)
                              .operationDays
                              .isEmpty
                          ? SizedBox(
                              width: width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    r'assets/people/calendar.svg',
                                    height: width * 0.25,
                                    width: width * 0.4,
                                  ),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Você ainda não registrou os horários de funcionamento de seu estabelecimento",
                                          style: TextStyle(
                                            color: textDarkGrey,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: defaultPadding,
                                        ),
                                        Text(
                                          "Clique em \"Horário de funcionamento\" para informar os horários de funcionamento de seu estabelecimento e cadastrar suas quadras",
                                          style: TextStyle(
                                            color: textLightGrey,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                SizedBox(
                                  width: courtInfoWidth,
                                  height: height,
                                  child: CourtInfo(
                                    viewModel: viewModel,
                                  ),
                                ),
                                const SizedBox(
                                  width: defaultPadding,
                                ),
                                Expanded(
                                  child: LayoutBuilder(
                                    builder: (ctx, cnst) {
                                      double myHeight = (cnst.maxHeight -
                                                      6 * defaultPadding) /
                                                  8 >
                                              50
                                          ? (cnst.maxHeight -
                                                  6 * defaultPadding) /
                                              8
                                          : 50;
                                      return Column(
                                        children: [
                                          Container(
                                            height: myHeight,
                                            padding: const EdgeInsets.all(2),
                                            margin: const EdgeInsets.only(
                                                right: 50),
                                            width: courtWeekdayWidth,
                                            child: const ResumedInfoRowHeader(),
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
                                                      dayIndex: index,
                                                      court: viewModel
                                                          .currentCourt,
                                                    ),
                                                    if (index != 6)
                                                      const SizedBox(
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