import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';

import '../../../../SharedComponents/Model/Hour.dart';
import '../../../../SharedComponents/View/SFDropDown.dart';

class HourSelector extends StatefulWidget {
  OperationDay operationDay;
  List<Hour> availableHours;

  HourSelector({
    required this.operationDay,
    required this.availableHours,
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
              value: widget.operationDay.isEnabled,
              onChanged: (value) {
                setState(() {
                  widget.operationDay.isEnabled = value!;
                });
              }),
          SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            child: Text(
              weekdayFull[widget.operationDay.weekDay],
              style: TextStyle(
                  color: widget.operationDay.isEnabled
                      ? textBlack
                      : textLightGrey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          widget.operationDay.isEnabled
              ? Row(
                  children: [
                    SFDropdown(
                      labelText: widget.operationDay.startingHour == null
                          ? widget.availableHours.first.hourString
                          : widget.operationDay.startingHour!.hourString,
                      items: widget.operationDay.endingHour == null
                          ? widget.availableHours
                              .where((hour) =>
                                  hour.hour < widget.availableHours.last.hour)
                              .map((hour) => hour.hourString)
                              .toList()
                          : widget.availableHours
                              .where((hour) =>
                                  hour.hour <
                                  widget.operationDay.endingHour!.hour)
                              .map((hour) => hour.hourString)
                              .toList(),
                      validator: (a) {},
                      onChanged: (a) {
                        setState(() {
                          widget.operationDay.startingHour = widget
                              .availableHours
                              .firstWhere((element) => element.hourString == a);
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Text(
                        "até",
                        style: TextStyle(
                            color: widget.operationDay.isEnabled
                                ? textBlack
                                : textLightGrey),
                      ),
                    ),
                    SFDropdown(
                      labelText: widget.operationDay.endingHour == null
                          ? widget.availableHours.last.hourString
                          : widget.operationDay.endingHour!.hourString,
                      items: widget.operationDay.startingHour == null
                          ? widget.availableHours
                              .where((hour) =>
                                  hour.hour > widget.availableHours.first.hour)
                              .map((hour) => hour.hourString)
                              .toList()
                          : widget.availableHours
                              .where((hour) =>
                                  hour.hour >
                                  widget.operationDay.startingHour!.hour)
                              .map((hour) => hour.hourString)
                              .toList(),
                      validator: (a) {},
                      onChanged: (a) {
                        setState(() {
                          widget.operationDay.endingHour = widget.availableHours
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
