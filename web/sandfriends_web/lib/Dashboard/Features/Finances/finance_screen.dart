
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/constants.dart';

import '../../ViewModel/DashboardViewModel.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  List<String> days = [
    "segunda",
    "terça",
    "quarta",
    "quinta",
    "sexta",
    "sábado",
    "domingo",
  ];

  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();
  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    double tableHeight = height * 0.9;
    double tableWidth = width * 0.7;
    double tableLineHeight = 25;
    double tableColumnWidth = 90;
    double tableColumnSpacing = 10;

    return Container(
      color: secondaryBack,
      width: width,
      height: height,
      child: Container(
        height: tableHeight,
        width: tableWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: secondaryPaper,
        ),
        padding: const EdgeInsets.all(defaultPadding),
        child: Scrollbar(
          controller: _vertical,
          thumbVisibility: true,
          trackVisibility: true,
          child: Scrollbar(
            controller: _horizontal,
            thumbVisibility: true,
            trackVisibility: true,
            notificationPredicate: (notif) => notif.depth == 1,
            child: SingleChildScrollView(
              controller: _vertical,
              child: SingleChildScrollView(
                controller: _horizontal,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          for (int i = 0; i < 24; i++)
                            Padding(
                              padding: i == 0
                                  ? const EdgeInsets.only(top: 5)
                                  : i == 23
                                      ? const EdgeInsets.only(bottom: 5)
                                      : const EdgeInsets.all(0),
                              child: Container(
                                alignment: Alignment.center,
                                height: tableLineHeight,
                                child: SizedBox(
                                  width: tableColumnWidth * 0.6,
                                  height: tableLineHeight * 0.7,
                                  child: Text(
                                    "${i.toString().padLeft(2, '0')}:00",
                                    style: const TextStyle(color: textDarkGrey),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    for (var day in days)
                      Container(
                        width: tableColumnWidth,
                        margin: EdgeInsets.symmetric(
                            horizontal: tableColumnSpacing),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          border: Border.all(color: primaryBlue, width: 0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              width: tableColumnWidth,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryBlue,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                border:
                                    Border.all(color: primaryBlue, width: 2),
                              ),
                              child: Text(
                                day,
                                style: const TextStyle(color: textWhite),
                              ),
                            ),
                            for (int i = 0; i < 24; i++)
                              Padding(
                                padding: i == 0
                                    ? const EdgeInsets.only(top: 5)
                                    : i == 23
                                        ? const EdgeInsets.only(bottom: 5)
                                        : const EdgeInsets.all(0),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: tableLineHeight,
                                  child: Container(
                                    width: tableColumnWidth * 0.6,
                                    height: tableLineHeight * 0.7,
                                    decoration: const BoxDecoration(
                                      color: divider,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
