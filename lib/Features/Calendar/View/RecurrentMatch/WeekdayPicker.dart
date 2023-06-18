import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';

import '../../../../Utils/Constants.dart';
import '../../../../Utils/SFDateTime.dart';

class WeekdayPicker extends StatefulWidget {
  Function(String) onChanged;

  WeekdayPicker({
    required this.onChanged,
  });

  @override
  State<WeekdayPicker> createState() => _WeekdayPickerState();
}

class _WeekdayPickerState extends State<WeekdayPicker> {
  String selectedIndex = weekdayRecurrent.first;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          for (var day in weekdayRecurrent)
            Row(
              children: [
                Radio(
                  value: day,
                  activeColor: primaryBlue,
                  groupValue: selectedIndex,
                  onChanged: (newValue) => setState(() {
                    selectedIndex = day;
                    widget.onChanged(day);
                  }),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Text(
                  day,
                  style: TextStyle(
                    color: textDarkGrey,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
