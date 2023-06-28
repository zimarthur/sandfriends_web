import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Home/View/OccupationWidget.dart';
import 'package:sandfriends_web/Features/Home/View/OnboardingWidget.dart';
import 'package:sandfriends_web/Features/Home/View/ResumedMatch.dart';
import 'package:sandfriends_web/Features/Home/ViewModel/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/SharedComponents/View/SFCard.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../Menu/ViewModel/MenuProvider.dart';
import 'NotificationCard.dart';

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
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (viewModel.needsOnboarding(context))
                  Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: OnboardingWidget(viewModel: viewModel),
                  ),
                SizedBox(
                  height: height,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.welcomeTitle,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: textBlack,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 2 * defaultPadding,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Partidas acontecendo hoje",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textDarkGrey,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                r'assets/icon/chevron_left.svg',
                              ),
                              const Text(
                                "09:00 - 10:00",
                                style: TextStyle(
                                  color: textDarkGrey,
                                ),
                              ),
                              SvgPicture.asset(
                                r'assets/icon/chevron_right.svg',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      SizedBox(
                        width: width,
                        height: 120,
                        child: ListView.builder(
                          itemCount: 4,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return const ResumedMatch();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 2 * defaultPadding,
                      ),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (layoutContext, layoutConstraints) => Row(
                            children: [
                              Expanded(
                                child: LayoutBuilder(builder:
                                    (layoutContext, layoutConstraints) {
                                  return Column(
                                    children: [
                                      SFCard(
                                        height:
                                            layoutConstraints.maxHeight * 0.3,
                                        width: layoutConstraints.maxWidth,
                                        title: "Faturamento hoje",
                                        child: const Center(
                                          child: Text(
                                            "R\$ 560,00",
                                            style: TextStyle(
                                                color: textBlue, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            layoutConstraints.maxHeight * 0.05,
                                      ),
                                      SFCard(
                                        height:
                                            layoutConstraints.maxHeight * 0.3,
                                        width: layoutConstraints.maxWidth,
                                        title: "Partidas agendadas hoje",
                                        child: const Center(
                                          child: Text(
                                            "15",
                                            style: TextStyle(
                                                color: textBlue, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            layoutConstraints.maxHeight * 0.05,
                                      ),
                                      SFCard(
                                        height:
                                            layoutConstraints.maxHeight * 0.3,
                                        width: layoutConstraints.maxWidth,
                                        title: "Recompensas hoje",
                                        child: const Center(
                                          child: Text(
                                            "2",
                                            style: TextStyle(
                                                color: textBlue, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                              Container(
                                height: layoutConstraints.maxHeight,
                                width: layoutConstraints.maxWidth * 0.3 < 300
                                    ? 300
                                    : layoutConstraints.maxWidth * 0.3,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 2,
                                  horizontal: defaultPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Ocupação das suas quadras hoje",
                                      style: TextStyle(
                                        color: textDarkGrey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: defaultPadding,
                                    ),
                                    OccupationWidget(
                                      title: "Geral",
                                      result: 0.85,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: defaultPadding,
                                      ),
                                      child: SFDivider(),
                                    ),
                                    OccupationWidget(
                                      title: "Quadra 1",
                                      result: 0.9,
                                    ),
                                    const SizedBox(
                                      height: defaultPadding,
                                    ),
                                    OccupationWidget(
                                      title: "Quadra 2",
                                      result: 0.8,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: layoutConstraints.maxHeight,
                                width: layoutConstraints.maxWidth * 0.4 < 450
                                    ? 450
                                    : layoutConstraints.maxWidth * 0.4,
                                padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 2,
                                  horizontal: defaultPadding,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryPaper,
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                  border: Border.all(
                                    color: divider,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Últimas atualizações",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: textDarkGrey,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: defaultPadding / 2,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            viewModel.notifications.length,
                                        itemBuilder: (context, index) {
                                          return NotificationCard(
                                            notification:
                                                viewModel.notifications[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
