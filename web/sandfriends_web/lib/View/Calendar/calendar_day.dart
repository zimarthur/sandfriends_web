import 'package:flutter/material.dart';

import '../../Resources/constants.dart';
import '../../controllers/MenuController.dart';
import 'package:provider/provider.dart';

class SFCalendarDay extends StatefulWidget {
  const SFCalendarDay({super.key});

  @override
  State<SFCalendarDay> createState() => _SFCalendarDayState();
}

class _SFCalendarDayState extends State<SFCalendarDay> {
  List<String> courts = [
    "quadra 1",
    "quadra 2",
    "quadra 3",
    "quadra 4",
    "quadra 5",
    "quadra 5",
    "quadra 5",
    "quadra 5",
    "quadra 5",
    "quadra 5",
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
    double tableColumnWidth = tableWidth * 0.105 < 70 ? 70 : tableWidth * 0.105;
    double tableHeaderHeight = tableLineHeight * 1.5;
    double tableDayWidth = (tableWidth - tableColumnWidth) * 0.95;
    double tableColumnDataWidth =
        tableDayWidth / courts.length < 70 ? 70 : tableDayWidth / courts.length;
    return Container(
      width: tableWidth,
      height: tableHeight,
      child: Stack(
        children: [
          Container(
            width: tableDayWidth,
            height: tableHeight,
            margin: EdgeInsets.only(left: tableColumnWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primaryBlue, width: 2),
            ),
            child: Column(
              children: [
                Container(
                  height: tableHeaderHeight,
                  alignment: Alignment.center,
                  width: tableDayWidth,
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    border: Border.all(color: primaryBlue, width: 2),
                  ),
                  child: Text(
                    "dias\n01/01",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textWhite),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: tableHeaderHeight + 2, bottom: 2),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: tableColumnWidth,
                    ),
                    Container(
                      width: tableDayWidth,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: primaryBlue,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Flexible(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: headerController,
                          scrollDirection: Axis.horizontal,
                          child: Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Row(
                                children: [
                                  for (var court in courts)
                                    Container(
                                      width: tableColumnDataWidth,
                                      height: tableHeaderHeight,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: divider,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "$court",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: textBlue),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Container(
                    child: Scrollbar(
                      controller: verticalController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      child: Scrollbar(
                        controller: horizontalController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        notificationPredicate: (notif) => notif.depth == 1,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SingleChildScrollView(
                            controller: verticalController,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    for (int hourIndex = 0;
                                        hourIndex < 24;
                                        hourIndex++)
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
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
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
                                Container(
                                  width: tableDayWidth,
                                  padding: EdgeInsets.only(right: 2, left: 2),
                                  child: Flexible(
                                    child: SingleChildScrollView(
                                      controller: horizontalController,
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          for (int court = 0;
                                              court < courts.length;
                                              court++)
                                            Column(
                                              children: [
                                                for (int hourIndex = 0;
                                                    hourIndex < 24;
                                                    hourIndex++)
                                                  InkWell(
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
                                                          hoveredHour =
                                                              hourIndex;
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              right: BorderSide(
                                                                  color:
                                                                      divider))),
                                                      alignment:
                                                          Alignment.center,
                                                      height: tableLineHeight,
                                                      width:
                                                          tableColumnDataWidth,
                                                      child: Container(
                                                        width:
                                                            tableColumnWidth *
                                                                0.6,
                                                        height:
                                                            tableLineHeight *
                                                                0.7,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: divider,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(16),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
