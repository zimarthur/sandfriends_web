import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import '../../../../Utils/Constants.dart';
import 'package:intl/intl.dart';
import '../../../../Utils/SFDateTime.dart';
import '../HourWidget.dart';

class SFCalendarWeek extends StatefulWidget {
  CalendarViewModel viewModel;

  SFCalendarWeek({required this.viewModel});

  @override
  State<SFCalendarWeek> createState() => _SFCalendarWeekState();
}

class _SFCalendarWeekState extends State<SFCalendarWeek> {
  ScrollController horizontalController = ScrollController(),
      verticalController = ScrollController(),
      headerController = ScrollController();

  int hoveredHour = -1;
  int hoveredDay = -1;

  @override
  void initState() {
    super.initState();

    horizontalController.addListener(() {
      headerController.jumpTo(horizontalController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.viewModel.workingHours.forEach((element) {
      print(element.hourString);
    });
    return LayoutBuilder(
      builder: (layoutContext, layoutConstraints) {
        double tableHeight = layoutConstraints.maxHeight * 0.95;
        double tableWidth = layoutConstraints.maxWidth;
        double tableLineHeight =
            tableHeight * 0.036 < 25 ? 25 : tableHeight * 0.036;
        double tableColumnSpacing = tableWidth * 0.01;
        double tableColumnWidth =
            tableWidth * 0.105 < 70 ? 70 : tableWidth * 0.105;
        double tableHeaderHeight = tableLineHeight * 1.5;
        return SizedBox(
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
                              for (var day in widget.viewModel.selectedWeek)
                                Container(
                                  width: tableColumnWidth,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: tableColumnSpacing),
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
                                      border: Border.all(
                                          color: primaryBlue, width: 2),
                                    ),
                                    child: Text(
                                      "${weekdayShort[getBRWeekday(day.weekday)]}\n${DateFormat('dd/MM').format(day)}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(color: textWhite),
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
                child: SingleChildScrollView(
                  controller: verticalController,
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            for (var hour in widget.viewModel.workingHours)
                              Container(
                                alignment: Alignment.center,
                                height: tableLineHeight,
                                child: Container(
                                  width: tableColumnWidth,
                                  height: tableLineHeight * 0.7,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: hoveredHour == hour.hour
                                          ? primaryBlue.withOpacity(0.3)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Text(
                                    hour.hourString,
                                    style: TextStyle(
                                        color: hoveredHour == hour.hour
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
                              for (int dayIndex = 0;
                                  dayIndex <
                                      widget.viewModel.selectedWeek.length;
                                  dayIndex++)
                                Container(
                                  width: tableColumnWidth,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: tableColumnSpacing),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: primaryBlue, width: 2),
                                      left: BorderSide(
                                          color: primaryBlue, width: 2),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      for (var hour
                                          in widget.viewModel.workingHours)
                                        Padding(
                                          padding: hour.hour ==
                                                  widget.viewModel.workingHours
                                                      .first.hour
                                              ? const EdgeInsets.only(top: 5)
                                              : hour.hour ==
                                                      widget
                                                          .viewModel
                                                          .workingHours
                                                          .last
                                                          .hour
                                                  ? const EdgeInsets.only(
                                                      bottom: 5)
                                                  : const EdgeInsets.all(0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: tableLineHeight,
                                            child:
                                                //hour.hour < widget.viewModel.operationDays.firstWhere((opDay) => opDay.weekDay == dayIndex,)
                                                HourWidget(
                                              hour.hour,
                                              dayIndex,
                                              hoveredHour,
                                              hoveredDay,
                                              tableLineHeight,
                                              tableColumnWidth,
                                              (value) {
                                                setState(() {
                                                  if (value == false) {
                                                    hoveredHour = -1;
                                                    hoveredDay = -1;
                                                  } else {
                                                    hoveredHour = hour.hour;
                                                    hoveredDay = dayIndex;
                                                  }
                                                });
                                              },
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
                              for (var day in widget.viewModel.selectedWeek)
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
                                        border: Border.all(
                                            color: primaryBlue, width: 2),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 2,
                                      width: tableColumnWidth - 4,
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
      },
    );
  }
}
