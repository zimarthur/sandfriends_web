import 'package:flutter/material.dart';

import '../../../../../Utils/Constants.dart';

import '../HourWidget.dart';

class SFCalendarDay extends StatefulWidget {
  double height;
  double width;

  SFCalendarDay(this.height, this.width);

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
  ];

  ScrollController horizontalController = ScrollController(),
      verticalController = ScrollController(),
      headerController = ScrollController();

  int hoveredHour = -1;
  int hoveredCourt = -1;

  @override
  void initState() {
    super.initState();

    horizontalController.addListener(() {
      headerController.jumpTo(horizontalController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    double tableHeight = widget.height * 0.95;
    double tableWidth = widget.width;
    double tableLineHeight =
        tableHeight * 0.036 < 25 ? 25 : tableHeight * 0.036;
    double tableColumnWidth = tableWidth * 0.105 < 70 ? 70 : tableWidth * 0.105;
    double tableHeaderHeight = tableLineHeight * 1.5;
    double tableDayWidth = (tableWidth - tableColumnWidth) * 0.95;
    double tableColumnDataWidth =
        tableDayWidth / courts.length < 70 ? 70 : tableDayWidth / courts.length;
    return SizedBox(
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
                  child: const Text(
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
                      decoration: const BoxDecoration(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Row(
                                children: [
                                  for (var court in courts)
                                    Container(
                                      width: tableColumnDataWidth,
                                      height: tableHeaderHeight,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: divider,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        court,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: textBlue),
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
                  child: SingleChildScrollView(
                    controller: verticalController,
                    child: Row(
                      children: [
                        Column(
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
                        Container(
                          width: tableDayWidth,
                          padding: const EdgeInsets.only(right: 2, left: 2),
                          child: Flexible(
                            child: SingleChildScrollView(
                              controller: horizontalController,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int courtIndex = 0;
                                      courtIndex < courts.length;
                                      courtIndex++)
                                    Column(
                                      children: [
                                        for (int hourIndex = 0;
                                            hourIndex < 24;
                                            hourIndex++)
                                          Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                right: BorderSide(
                                                  color: divider,
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            height: tableLineHeight,
                                            width: tableColumnDataWidth,
                                            child: HourWidget(
                                              hourIndex,
                                              courtIndex,
                                              hoveredHour,
                                              hoveredCourt,
                                              tableLineHeight,
                                              tableColumnWidth,
                                              (value) {
                                                setState(() {
                                                  if (value == false) {
                                                    hoveredHour = -1;
                                                    hoveredCourt = -1;
                                                  } else {
                                                    hoveredHour = hourIndex;
                                                    hoveredCourt = courtIndex;
                                                  }
                                                });
                                              },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
