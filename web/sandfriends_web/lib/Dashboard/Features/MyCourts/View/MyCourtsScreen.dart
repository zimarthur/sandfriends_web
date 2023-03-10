import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/SFCalendarWeek.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/View/MyCourtsTabSelector.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFTabs.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'dart:io';

import 'CourtInfo.dart';

class MyCourtsScreen extends StatefulWidget {
  const MyCourtsScreen({super.key});

  @override
  State<MyCourtsScreen> createState() => _MyCourtsScreenState();
}

class _MyCourtsScreenState extends State<MyCourtsScreen> {
  final MyCourtsViewModel viewModel = MyCourtsViewModel();

  late ScrollController scrollController;
  bool isScrollOverflown = false;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      isScrollOverflown = scrollController.position.maxScrollExtent >
          scrollController.position.pixels;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    double courtInfo = 300;
    double courtCalendar = width - courtInfo - 8 * defaultPadding;
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
                      buttonType: ButtonType.Primary,
                      onTap: () {
                        viewModel.setWorkingHours(context);
                      },
                      textPadding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding * 2,
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
                    Row(
                      children: [
                        MyCourtsTabSelector(
                          title: "Adicionar Quadra",
                          isSelected: true,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return MyCourtsTabSelector(
                                  title: "Quadra $index",
                                  isSelected: false,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
                      padding: EdgeInsets.all(defaultPadding),
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
                            width: courtInfo,
                            height: height,
                            child: CourtInfo(),
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          SFCalendarWeek(height, courtCalendar)
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
