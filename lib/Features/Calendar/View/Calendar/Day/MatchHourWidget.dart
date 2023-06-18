import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import '../../../../../SharedComponents/Model/AppMatch.dart';
import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../SharedComponents/Model/Sport.dart';

class MatchHourWidget extends StatefulWidget {
  VoidCallback onTapMatch;
  VoidCallback onUnblockHour;
  bool blocked;
  String blockedReason;
  bool isExpired;
  String title;
  Hour startingHour;
  Hour endingHour;
  Sport? sport;

  MatchHourWidget({
    required this.onTapMatch,
    required this.onUnblockHour,
    required this.blocked,
    required this.blockedReason,
    required this.isExpired,
    required this.title,
    required this.startingHour,
    required this.endingHour,
    required this.sport,
  });

  @override
  State<MatchHourWidget> createState() => _MatchHourWidgetState();
}

class _MatchHourWidgetState extends State<MatchHourWidget> {
  bool buttonExpanded = false;
  bool isOnHover = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (layourContext, layoutConstraints) {
        return InkWell(
          onTap: () {
            if (widget.blocked == false) {
              widget.onTapMatch();
            }
          },
          mouseCursor: widget.blocked == false
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onHover: (value) {
            setState(() {
              isOnHover = value;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.blocked == true
                    ? [
                        secondaryYellow.withOpacity(0.6),
                        secondaryYellow.withOpacity(0.3),
                        secondaryYellow.withOpacity(0.2),
                      ]
                    : [
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
            child: widget.blocked == true
                ? Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Horário Bloqueado",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: secondaryYellowDark),
                          ),
                          Text(
                            widget.blockedReason,
                            maxLines: 2,
                            style: TextStyle(
                              color: textDarkGrey,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (isOnHover && !widget.isExpired)
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: widget.onUnblockHour,
                            onHover: (value) {
                              setState(() {
                                buttonExpanded = value;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius),
                                color: textWhite,
                              ),
                              padding: EdgeInsets.all(
                                  layoutConstraints.maxHeight * 0.1),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    r"assets/icon/check_circle.svg",
                                    color: green,
                                  ),
                                  if (buttonExpanded)
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              layoutConstraints.maxHeight * 0.1,
                                        ),
                                        Text(
                                          "Liberar Horário",
                                          style: TextStyle(color: green),
                                        )
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "${widget.startingHour.hourString} - ${widget.endingHour.hourString}",
                        style: TextStyle(color: textDarkGrey),
                      ),
                      Text(
                        "${widget.sport!.description}",
                        style: TextStyle(color: textDarkGrey),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
