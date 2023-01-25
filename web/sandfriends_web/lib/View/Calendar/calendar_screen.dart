import 'package:flutter/material.dart';
import 'package:sandfriends_web/Resources/constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/View/Calendar/calendar_day.dart';
import 'package:sandfriends_web/View/Calendar/calendar_week.dart';
import 'package:sandfriends_web/controllers/MenuController.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import '../../responsive.dart';

var today = DateUtils.dateOnly(DateTime.now());

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late bool weekly;

  List<DateTime?> initialDates = [];

  @override
  void initState() {
    super.initState();

    weekly = false;
  }

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<MenuController>(context).getDashboardWidth(context);
    double height =
        Provider.of<MenuController>(context).getDashboardHeigth(context);

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      color: secondaryBack,
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: secondaryPaper,
            ),
            padding: const EdgeInsets.all(defaultPadding),
            child: weekly ? SFCalendarWeek() : SFCalendarDay(),
          ),
          SizedBox(
            width: defaultPadding,
          ),
          Expanded(
              child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    weekly = !weekly;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: textDisabled,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: weekly ? primaryBlue : textDisabled,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Semanal",
                            style: TextStyle(
                                color: weekly ? textWhite : textDarkGrey),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: weekly ? textDisabled : primaryBlue,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Diário",
                            style: TextStyle(
                                color: weekly ? textDarkGrey : textWhite),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    weekdayLabels: [
                      'Dom',
                      'Seg',
                      'Ter',
                      'Qua',
                      'Qui',
                      'Sex',
                      'Sáb'
                    ],
                    firstDate: DateTime(today.year, today.month, today.day),
                    calendarType: CalendarDatePicker2Type.range,
                    selectedDayHighlightColor: primaryBlue,
                    weekdayLabelTextStyle: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    controlsTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  initialValue: initialDates,
                  onValueChanged: (values) {
                    setState(() {});
                  }),
            ],
          )),
        ],
      ),
    );
  }
}
