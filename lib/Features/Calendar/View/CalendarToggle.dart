import 'package:sandfriends_web/Features/Calendar/Model/CalendarType.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter/material.dart';

class CalendarToggle extends StatefulWidget {
  List<CalendarType> labels = [CalendarType.Weekly, CalendarType.Daily];
  CalendarType selectedIndex;
  Function(CalendarType) onChanged;

  CalendarToggle(this.selectedIndex, this.onChanged, {super.key});
  @override
  State<CalendarToggle> createState() => _CalendarToggleState();
}

class _CalendarToggleState extends State<CalendarToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: textDisabled,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int labelIndex = 0;
              labelIndex < widget.labels.length;
              labelIndex++)
            Expanded(
              child: InkWell(
                onTap: () {
                  widget.onChanged(widget.labels[labelIndex]);
                },
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: widget.labels[labelIndex] == widget.selectedIndex
                        ? primaryBlue
                        : textDisabled,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.labels[labelIndex] == CalendarType.Weekly
                        ? "Semanal"
                        : "Diário",
                    style: TextStyle(
                        color: widget.labels[labelIndex] == widget.selectedIndex
                            ? textWhite
                            : textDarkGrey),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
