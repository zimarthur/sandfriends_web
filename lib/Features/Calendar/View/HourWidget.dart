import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppMatch.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import 'package:provider/provider.dart';
import '../../../SharedComponents/Model/Hour.dart';

class HourWidget extends StatefulWidget {
  bool isHovered;
  DateTime date;
  Hour hour;
  double height;
  double width;
  List<AppMatch> matches;
  Function(bool) onChanged;
  VoidCallback onTap;

  HourWidget({
    required this.isHovered,
    required this.date,
    required this.hour,
    required this.matches,
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
  void initState() {
    if (widget.matches.length ==
        Provider.of<DataProvider>(context, listen: false).courts.length) {
      widgetColor = secondaryYellow;
      onHoverColor = secondaryYellowDark;
    } else if (isHourPast(widget.date, widget.hour)) {
      widgetColor = divider.withOpacity(0.3);
      onHoverColor = divider;
    } else {
      widgetColor = secondaryGreen;
      onHoverColor = secondaryGreenDark;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        widget.onChanged(value);
      },
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
