import 'package:flutter/material.dart';
import 'package:sandfriends_web/Resources/constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/View/Calendar/calendar_day.dart';
import 'package:sandfriends_web/View/Calendar/calendar_toggle.dart';
import 'package:sandfriends_web/View/Calendar/calendar_week.dart';
import 'package:sandfriends_web/View/Calendar/date_picker.dart';
import 'package:sandfriends_web/controllers/MenuController.dart';

import '../../responsive.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<MenuController>(context).getDashboardWidth(context);
    double height =
        Provider.of<MenuController>(context).getDashboardHeigth(context);
    double calendarFilterWidth = 300;
    double calendarWidth = width - calendarFilterWidth - 8 * defaultPadding;

    bool weekCalendar = Provider.of<MenuController>(context).isCalendarWeekly();

    return Container(
      color: secondaryBack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: secondaryPaper,
            ),
            padding: const EdgeInsets.all(defaultPadding),
            margin: EdgeInsets.all(defaultPadding),
            child: weekCalendar
                ? SFCalendarWeek(height, calendarWidth)
                : SFCalendarDay(height, calendarWidth),
          ),
          Container(
              width: calendarFilterWidth,
              height: height,
              margin: EdgeInsets.all(defaultPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CalendarToggle(
                        ["Semanal", "Diário"],
                        Provider.of<MenuController>(context)
                            .selectedCalendarStyle, (index) {
                      setState(() {
                        Provider.of<MenuController>(context, listen: false)
                            .selectedCalendarStyle = index;
                      });
                    }),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    DatePicker(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
