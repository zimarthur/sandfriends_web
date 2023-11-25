import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/viewport_offset.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Calendar/View/Mobile/CalendarDatePickerMobile.dart';
import 'package:sandfriends_web/Features/Calendar/View/Mobile/CalendarHeader.dart';
import 'package:sandfriends_web/Features/Menu/View/Mobile/SFStandardHeader.dart';
import 'package:sandfriends_web/Utils/String.dart';
import '../../../../Utils/Constants.dart';
import '../../../../Utils/SFDateTime.dart';
import '../../ViewModel/CalendarViewModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarViewModel viewModel = CalendarViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initCalendarViewModel(context, true);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<CalendarViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              children: [
                CalendarHeader(),
                Expanded(
                    child: Column(
                  children: [
                    CalendarDatePickerMobile(),
                    Expanded(
                        child: ListView.builder(
                      itemCount: viewModel.selectedDayWorkingHours.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2,
                              color: divider,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                              ),
                              height: 100,
                              child: Text(
                                viewModel
                                    .selectedDayWorkingHours[index].hourString,
                                style: TextStyle(color: textDarkGrey),
                              ),
                            ),
                          ],
                        );
                      },
                    ))
                  ],
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
