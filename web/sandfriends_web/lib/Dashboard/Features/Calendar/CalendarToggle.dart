import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter/material.dart';

class CalendarToggle extends StatefulWidget {
  List<String> labels;
  int selectedIndex = 0;
  Function(int) onChanged;

  CalendarToggle(this.labels, this.selectedIndex, this.onChanged);
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
                  setState(() {
                    widget.selectedIndex = labelIndex;
                    widget.onChanged(labelIndex);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: labelIndex == widget.selectedIndex
                        ? primaryBlue
                        : textDisabled,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.labels[labelIndex],
                    style: TextStyle(
                        color: labelIndex == widget.selectedIndex
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
