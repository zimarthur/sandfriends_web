import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/Model/CalendarType.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DashboardViewModel.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFTabs.dart';
import 'Calendar/SFCalendarDay.dart';
import 'CalendarToggle.dart';
import 'Calendar/SFCalendarWeek.dart';
import '../View/DatePicker.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarViewModel viewModel = CalendarViewModel();

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    double calendarFilterWidth = 300;

    return ChangeNotifierProvider<CalendarViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<CalendarViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    viewModel.setNoMatchReservedWidget(context, viewModel);
                  },
                  child: const SFHeader(
                      header: "Calendário",
                      description:
                          "Acompanhe as partidas agendadas e veja seus mensalistas"),
                ),
                SFTabs(
                  tabs: const ["Partidas", "Mensalistas"],
                  onTap: (newValue) {
                    viewModel.matchRecurrentView = newValue;
                  },
                  selectedPosition: viewModel.matchRecurrentView,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: LayoutBuilder(
                            builder: (layoutContext, layoutConstraints) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: secondaryPaper,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding,
                            ),
                            child: viewModel.calendarView == CalendarType.Weekly
                                ? SFCalendarWeek(
                                    layoutConstraints.maxHeight,
                                    layoutConstraints.maxWidth,
                                  )
                                : SFCalendarDay(
                                    layoutConstraints.maxHeight,
                                    layoutConstraints.maxWidth,
                                  ),
                          );
                        }),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      SizedBox(
                        width: calendarFilterWidth,
                        height: height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CalendarToggle(viewModel.calendarView, (calType) {
                                viewModel.calendarView = calType;
                              }),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              const DatePicker(),
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
        },
      ),
    );
  }
}
