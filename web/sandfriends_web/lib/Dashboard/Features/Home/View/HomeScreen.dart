import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/View/FeedItem.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/View/ResumedMatch.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/ViewModel/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/SharedComponents/Model/PaymentType.dart';
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
                    "Partidas acontecendo agora",
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
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Ver todas",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: textBlue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ResumedMatch();
                  },
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (layoutContext, layoutConstraints) => Row(
                    children: [
                      Expanded(
                        child: Container(),
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
