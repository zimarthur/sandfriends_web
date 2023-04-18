import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/View/FeedItem.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/View/OccupationWidget.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/View/OnboardingWidget.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/View/ResumedMatch.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/ViewModel/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/SharedComponents/Model/PaymentType.dart';
import 'package:sandfriends_web/SharedComponents/View/SFCard.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFPaymentStatus.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../ViewModel/DashboardViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (viewModel.needsOnboarding(context))
                OnboardingWidget(viewModel: viewModel),
              Text(
                viewModel.welcomeTitle,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: textBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2 * defaultPadding,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Partidas acontecendo hoje",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: textDarkGrey,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        r'assets/icon/chevron_left.svg',
                      ),
                      Text(
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
              SizedBox(
                height: defaultPadding / 2,
              ),
              SizedBox(
                width: width,
                height: 120,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ResumedMatch();
                  },
                ),
              ),
              SizedBox(
                height: 2 * defaultPadding,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (layoutContext, layoutConstraints) => Row(
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                            builder: (layoutContext, layoutConstraints) {
                          return Column(
                            children: [
                              SFCard(
                                height: layoutConstraints.maxHeight * 0.3,
                                width: layoutConstraints.maxWidth,
                                title: "Faturamento hoje",
                                child: Center(
                                  child: Text(
                                    "R\$ 560,00",
                                    style: TextStyle(
                                        color: textBlue, fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: layoutConstraints.maxHeight * 0.05,
                              ),
                              SFCard(
                                height: layoutConstraints.maxHeight * 0.3,
                                width: layoutConstraints.maxWidth,
                                title: "Partidas agendadas hoje",
                                child: Center(
                                  child: Text(
                                    "15",
                                    style: TextStyle(
                                        color: textBlue, fontSize: 20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: layoutConstraints.maxHeight * 0.05,
                              ),
                              SFCard(
                                height: layoutConstraints.maxHeight * 0.3,
                                width: layoutConstraints.maxWidth,
                                title: "Recompensas hoje",
                                child: Center(
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
                        margin: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: defaultPadding / 2,
                          horizontal: defaultPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ocupação das suas quadras hoje",
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            ),
                            SizedBox(
                              height: defaultPadding,
                            ),
                            OccupationWidget(
                              title: "Geral",
                              result: 0.85,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding,
                              ),
                              child: SFDivider(),
                            ),
                            OccupationWidget(
                              title: "Quadra 1",
                              result: 0.9,
                            ),
                            SizedBox(
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
                        padding: EdgeInsets.symmetric(
                          vertical: defaultPadding / 2,
                          horizontal: defaultPadding,
                        ),
                        decoration: BoxDecoration(
                          color: secondaryPaper,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                          border: Border.all(
                            color: divider,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Últimas atualizações",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: textDarkGrey,
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: defaultPadding / 2,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return FeedItem();
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
          );
        },
      ),
    );
  }
}
