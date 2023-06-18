import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppMatch.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import 'package:provider/provider.dart';
import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../Model/DayMatch.dart';

class HourWidget extends StatefulWidget {
  bool isHovered;
  DateTime date;
  double height;
  double width;
  bool isOperationHour;
  bool isExpired;
  int matchesLength;
  Hour startingHour;
  Function(bool) onChanged;
  VoidCallback onTap;

  HourWidget({
    required this.isHovered,
    required this.date,
    required this.isOperationHour,
    required this.isExpired,
    required this.matchesLength,
    required this.startingHour,
    required this.height,
    required this.width,
    required this.onChanged,
    required this.onTap,
  });
  @override
  State<HourWidget> createState() => _HourWidgetState();
}

class _HourWidgetState extends State<HourWidget> {
  late Color widgetColor;
  late Color onHoverColor;

  @override
  Widget build(BuildContext context) {
    if (!widget.isOperationHour) {
      widgetColor = divider;
      onHoverColor = divider;
    } else if (widget.isExpired) {
      if (widget.matchesLength ==
          Provider.of<DataProvider>(context, listen: false).courts.length) {
        widgetColor = secondaryYellow.withOpacity(0.4);
        onHoverColor = secondaryYellowDark.withOpacity(0.4);
      } else {
        widgetColor = secondaryGreen.withOpacity(0.4);
        onHoverColor = secondaryGreenDark.withOpacity(0.4);
      }
    } else if (widget.matchesLength ==
        Provider.of<DataProvider>(context, listen: false).courts.length) {
      widgetColor = secondaryYellow;
      onHoverColor = secondaryYellowDark;
    } else {
      widgetColor = secondaryGreen;
      onHoverColor = secondaryGreenDark;
    }
    return InkWell(
      onTap: widget.isOperationHour ? widget.onTap : () {},
      onHover: (value) {
        if (widget.isOperationHour) {
          widget.onChanged(value);
        }
      },
      mouseCursor: widget.isOperationHour
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: Container(
        width: widget.width * 0.7,
        height: widget.height * 0.7,
        decoration: BoxDecoration(
          color: widgetColor,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: widget.isHovered
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: onHoverColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
