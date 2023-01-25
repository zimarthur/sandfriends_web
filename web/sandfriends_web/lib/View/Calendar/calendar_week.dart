import 'package:flutter/material.dart';

import '../../Resources/constants.dart';
import '../../controllers/MenuController.dart';
import 'package:provider/provider.dart';

class SFCalendarWeek extends StatefulWidget {
  const SFCalendarWeek({super.key});

  @override
  State<SFCalendarWeek> createState() => _SFCalendarWeekState();
}

class _SFCalendarWeekState extends State<SFCalendarWeek> {
  List<String> days = [
    "segunda",
    "terça",
    "quarta",
    "quinta",
    "sexta",
    "sábado",
    "domingo",
  ];

  List<String> courts = [
    "quadra 1",
    "quadra 2",
    "quadra 3",
    "quadra 4",
    "quadra 5",
  ];

  ScrollController horizontalController = ScrollController(),
      verticalController = ScrollController(),
      headerController = ScrollController();

  int hoveredHour = -1;

  @override
  void initState() {
    super.initState();

    horizontalController.addListener(() {
      headerController.jumpTo(horizontalController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<MenuController>(context).getDashboardWidth(context);
    double height =
        Provider.of<MenuController>(context).getDashboardHeigth(context);
    double tableHeight = height * 0.95;
    double tableWidth = width * 0.7;
    double tableLineHeight =
        tableHeight * 0.036 < 25 ? 25 : tableHeight * 0.036;
    double tableColumnSpacing = tableWidth * 0.01;
    double tableColumnWidth = tableWidth * 0.105 < 70 ? 70 : tableWidth * 0.105;
    double tableHeaderHeight = tableLineHeight * 1.5;
    return Container(
      width: tableWidth,
      height: tableHeight,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: tableColumnWidth,
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: headerController,
                  scrollDirection: Axis.horizontal,
                  child: Flexible(
                    child: Container(
                      child: Row(
                        children: [
                          for (var day in days)
                            Container(
                              width: tableColumnWidth,
                              margin: EdgeInsets.symmetric(
                                  horizontal: tableColumnSpacing),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                border:
                                    Border.all(color: primaryBlue, width: 0),
                              ),
                              child: Container(
                                height: tableHeaderHeight,
                                alignment: Alignment.center,
                                width: tableColumnWidth,
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
                                  "$day\n01/01",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: textWhite),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Scrollbar(
              controller: verticalController,
              thumbVisibility: true,
              trackVisibility: true,
              child: Scrollbar(
                controller: horizontalController,
                thumbVisibility: true,
                trackVisibility: true,
                notificationPredicate: (notif) => notif.depth == 1,
                child: SingleChildScrollView(
                  controller: verticalController,
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            for (int hourIndex = 0; hourIndex < 24; hourIndex++)
                              Container(
                                alignment: Alignment.center,
                                height: tableLineHeight,
                                child: Container(
                                  width: tableColumnWidth,
                                  height: tableLineHeight * 0.7,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: hoveredHour == hourIndex
                                          ? primaryBlue.withOpacity(0.3)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Text(
                                    "${hourIndex.toString().padLeft(2, '0')}:00",
                                    style: TextStyle(
                                        color: hoveredHour == hourIndex
                                            ? primaryDarkBlue
                                            : textDarkGrey),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          controller: horizontalController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var day in days)
                                Container(
                                  width: tableColumnWidth,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: tableColumnSpacing),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: primaryBlue,
                                      ),
                                      left: BorderSide(
                                        color: primaryBlue,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      for (int hourIndex = 0;
                                          hourIndex < 24;
                                          hourIndex++)
                                        Padding(
                                          padding: hourIndex == 0
                                              ? EdgeInsets.only(top: 5)
                                              : hourIndex == 23
                                                  ? EdgeInsets.only(bottom: 5)
                                                  : EdgeInsets.all(0),
                                          child: InkWell(
                                            onTap: () {},
                                            onFocusChange: (value) {
                                              setState(() {
                                                hoveredHour = -1;
                                              });
                                            },
                                            onHover: (value) {
                                              setState(() {
                                                if (value == false)
                                                  hoveredHour = -1;
                                                else
                                                  hoveredHour = hourIndex;
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: tableLineHeight,
                                              child: Container(
                                                width: tableColumnWidth * 0.6,
                                                height: tableLineHeight * 0.7,
                                                decoration: BoxDecoration(
                                                  color: divider,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(16),
                                                  ),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: tableColumnWidth,
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: headerController,
                  scrollDirection: Axis.horizontal,
                  child: Flexible(
                    child: Container(
                      child: Row(
                        children: [
                          for (var day in days)
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  height: 16,
                                  width: tableColumnWidth,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: tableColumnSpacing),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: primaryBlue),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: tableColumnWidth - 2,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: tableColumnSpacing),
                                  color: secondaryPaper,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
