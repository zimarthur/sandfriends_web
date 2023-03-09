import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/Model/Hour.dart';
import '../../../../SharedComponents/View/SFDropDown.dart';

class HourSelector extends StatefulWidget {
  String title;
  List<Hour> availableHours;
  Hour startHour;
  Hour endHour;

  HourSelector({
    required this.title,
    required this.availableHours,
    required this.startHour,
    required this.endHour,
  });

  @override
  State<HourSelector> createState() => _HourSelectorState();
}

class _HourSelectorState extends State<HourSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SFDropdown(
            labelText: widget.startHour.hourString,
            items: widget.availableHours
                .where((hour) => hour.hour < widget.endHour.hour)
                .map((hour) => hour.hourString)
                .toList(),
            validator: (a) {},
            onChanged: (a) {
              setState(() {
                widget.startHour = widget.availableHours
                    .firstWhere((element) => element.hourString == a);
              });
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              "até",
            ),
          ),
          SFDropdown(
            labelText: widget.endHour.hourString,
            items: widget.availableHours
                .where((hour) => hour.hour > widget.startHour.hour)
                .map((hour) => hour.hourString)
                .toList(),
            validator: (a) {},
            onChanged: (a) {
              setState(() {
                widget.endHour = widget.availableHours
                    .firstWhere((element) => element.hourString == a);
              });
            },
          ),
        ],
      ),
    );
  }
}
