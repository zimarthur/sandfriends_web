import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';

import 'package:sandfriends_web/Dashboard/ViewModel/DashboardViewModel.dart';

import '../../../SharedComponents/View/SFHeader.dart';
import '../../../SharedComponents/View/SFTabs.dart';
import '../../../Utils/Responsive.dart';
import 'SFCalendarDay.dart';
import 'CalendarToggle.dart';
import 'SFCalendarWeek.dart';
import 'DatePicker.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    double calendarFilterWidth = 300;
    double calendarWidth = width - calendarFilterWidth - 8 * defaultPadding;

    bool weekCalendar =
        Provider.of<DashboardViewModel>(context).isCalendarWeekly();

    return Container(
      color: secondaryBack,
      child: Column(
        children: [
          SFHeader(
              header: "Calendário",
              description:
                  "Acompanhe as partidas agendadas e veja seus mensalistas"),
          SFTabs(
            tabs: ["Partidas", "Mensalistas"],
            onTap: (p0) {},
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: secondaryPaper,
                  ),
                  padding: const EdgeInsets.all(defaultPadding),
                  child: weekCalendar
                      ? SFCalendarWeek(
                          height,
                          calendarWidth,
                        )
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
                              Provider.of<DashboardViewModel>(context)
                                  .selectedCalendarStyle, (index) {
                            setState(() {
                              Provider.of<DashboardViewModel>(context,
                                      listen: false)
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
          ),
        ],
      ),
    );
  }
}
