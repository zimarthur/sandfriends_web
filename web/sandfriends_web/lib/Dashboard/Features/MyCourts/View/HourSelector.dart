import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/Model/Hour.dart';
import '../../../../SharedComponents/View/SFDropDown.dart';

class HourSelector extends StatefulWidget {
  bool isEnabled;
  String title;
  List<Hour> availableHours;
  Hour startHour;
  Hour endHour;

  HourSelector({
    required this.isEnabled,
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
          Checkbox(
              value: widget.isEnabled,
              onChanged: (value) {
                setState(() {
                  widget.isEnabled = value!;
                });
              }),
          SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            child: Text(
              widget.title,
              style: TextStyle(
                  color: widget.isEnabled ? textBlack : textLightGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widget.isEnabled
              ? Row(
                  children: [
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
                        style: TextStyle(
                            color:
                                widget.isEnabled ? textBlack : textLightGrey),
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
                )
              : Container(),
        ],
      ),
    );
  }
}
