import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import '../../../../../Utils/Constants.dart';
import '../../../../Menu/ViewModel/MenuProvider.dart';
import '../CalendarToggle.dart';
import 'DatePicker.dart';

class MatchFilter extends StatelessWidget {
  CalendarViewModel viewModel;
  MatchFilter({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
    return SizedBox(
      width: 300,
      height: height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CalendarToggle(
              selectedIndex: viewModel.periodType,
              onChanged: (calType) {
                viewModel.periodType = calType;
              },
              horizontal: true,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            DatePicker(
              onDateSelected: (newDate) {
                viewModel.setSelectedDay(context, newDate);
              },
            ),
          ],
        ),
      ),
    );
  }
}
