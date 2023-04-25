import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:sandfriends_web/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';

var today = DateUtils.dateOnly(DateTime.now());

class DatePicker extends StatefulWidget {
  Function(DateTime) onDateSelected;
  DatePicker({
    required this.onDateSelected,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  List<DateTime?> initialDates = [];

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        weekdayLabels: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
        firstDate: Provider.of<DataProvider>(context, listen: false)
            .store!
            .approvalDate,
        calendarType: CalendarDatePicker2Type.single,
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
        if (values.first != null) {
          widget.onDateSelected(values.first!);
        }
        setState(() {});
      },
    );
  }
}
