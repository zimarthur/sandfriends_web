import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Home/View/Mobile/CourtOccupationWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../Utils/Constants.dart';
import '../../ViewModel/HomeViewModel.dart';
import 'KPI.dart';
import 'MatchCard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    viewModel.initHomeScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool canSwipe = true;
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: KPI(
                          title: "Faturamento hoje",
                          value: viewModel.todaysProfit.toInt().toString(),
                          iconPath: r"assets/icon/money.svg",
                          primaryColor: success,
                          secondaryColor: success50,
                          isCurrency: true,
                        ),
                      ),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                        child: KPI(
                          title: "Partidas hoje",
                          value: viewModel.matches.length.toString(),
                          iconPath: r"assets/icon/court.svg",
                          primaryColor: forecast,
                          secondaryColor: forecast50,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: CourtOccupationWidget(
                    viewModel: viewModel,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2 * defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Partidas hoje",
                                style: TextStyle(
                                    color: textBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (!viewModel.isLowestHour) {
                                  viewModel.decreaseHour();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 4,
                                ),
                                child: SvgPicture.asset(
                                  r"assets/icon/chevron_left.svg",
                                  color: viewModel.isLowestHour
                                      ? textLightGrey
                                      : primaryBlue,
                                ),
                              ),
                            ),
                            Text(
                              viewModel.displayedHour.hourString,
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (!viewModel.isHighestHour) {
                                  viewModel.increaseHour();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding / 4,
                                ),
                                child: SvgPicture.asset(
                                  r"assets/icon/chevron_right.svg",
                                  color: viewModel.isHighestHour
                                      ? textLightGrey
                                      : primaryBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultPadding),
                        width: width,
                        child: viewModel.matchesOnDisplayesHour.isEmpty
                            ? Container(
                                height: 100,
                                alignment: Alignment.center,
                                child: Text(
                                  "sem partidas nesse horário",
                                  style: TextStyle(
                                    color: textDarkGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    viewModel.matchesOnDisplayesHour.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    child: MatchCard(
                                        match: viewModel
                                            .matchesOnDisplayesHour[index]),
                                  );
                                },
                              ),
                      )
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
