import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/TypesExtensions.dart';
import '../../../../Utils/Constants.dart';
import '../../../../Utils/SFDateTime.dart';
import '../../../Menu/View/Mobile/SFStandardHeader.dart';

class CalendarDatePickerMobile extends StatelessWidget {
  const CalendarDatePickerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarViewModel viewModel = Provider.of<CalendarViewModel>(context);
    return Container(
      color: primaryBlue,
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: secondaryBack,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  defaultBorderRadius,
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var day in viewModel.selectedWeek)
                    day ==
                            viewModel.selectedWeek[
                                (viewModel.selectedWeek.length / 2).floor()]
                        ? InkWell(
                            onTap: () => viewModel.setSelectedDay(context, day),
                            child: SizedBox(
                              height: 90,
                              width: 70,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        defaultBorderRadius,
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          primaryLightBlue,
                                          primaryBlue,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(3),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        defaultBorderRadius,
                                      ),
                                      color: secondaryPaper,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          weekdayShort[
                                                  getSFWeekday(day.weekday)]
                                              .capitalize(),
                                          style: TextStyle(
                                            color: textBlue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          day.day.toString(),
                                          style: TextStyle(
                                            color: textBlue,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: InkWell(
                              onTap: () =>
                                  viewModel.setSelectedDay(context, day),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    weekdayShort[getSFWeekday(day.weekday)]
                                        .capitalize(),
                                    style: TextStyle(
                                      color: textWhite,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    day.day.toString(),
                                    style: TextStyle(
                                      color: textWhite,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                ],
              )),
        ],
      ),
    );
  }
}
