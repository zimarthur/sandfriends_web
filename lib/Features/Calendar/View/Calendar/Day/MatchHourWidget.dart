import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../../SharedComponents/Model/AppMatch.dart';

class MatchHourWidget extends StatefulWidget {
  AppMatch match;
  Function(AppMatch) onTapMatch;
  MatchHourWidget({
    required this.match,
    required this.onTapMatch,
  });

  @override
  State<MatchHourWidget> createState() => _MatchHourWidgetState();
}

class _MatchHourWidgetState extends State<MatchHourWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTapMatch(widget.match),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryLightBlue.withOpacity(0.6),
              primaryLightBlue.withOpacity(0.3),
              primaryLightBlue.withOpacity(0.2),
            ],
          ),
        ),
        margin: EdgeInsets.symmetric(
            vertical: defaultPadding / 4, horizontal: defaultPadding / 2),
        padding: EdgeInsets.symmetric(
            vertical: defaultPadding / 2, horizontal: defaultPadding),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Partida de ${widget.match.matchCreator}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${widget.match.startingHour.hourString} - ${widget.match.endingHour.hourString}",
              style: TextStyle(color: textDarkGrey),
            ),
            Text(
              "${widget.match.sport.description}",
              style: TextStyle(color: textDarkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
