import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Model/CalendarType.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppRecurrentMatch.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/SFDateTime.dart';
import '../../../../../../SharedComponents/Model/AppMatch.dart';
import '../../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../../SharedComponents/Model/Sport.dart';
import '../../../../Model/PeriodType.dart';

class MatchHourWidget extends StatefulWidget {
  VoidCallback onTapMatch;
  VoidCallback onUnblockHour;
  AppMatch? match;
  AppRecurrentMatch? recurrentMatch;
  CalendarType calendarType;

  MatchHourWidget({
    required this.onTapMatch,
    required this.onUnblockHour,
    required this.match,
    required this.recurrentMatch,
    required this.calendarType,
  });

  @override
  State<MatchHourWidget> createState() => _MatchHourWidgetState();
}

class _MatchHourWidgetState extends State<MatchHourWidget> {
  bool buttonExpanded = false;
  bool isOnHover = false;

  late String title;
  late String subtitle;
  late bool blocked;
  late String startingHour;
  late String endingHour;
  late bool canBlockUnblock;

  @override
  Widget build(BuildContext context) {
    if (widget.match != null) {
      blocked = widget.match!.blocked;
      canBlockUnblock =
          !isHourPast(widget.match!.date, widget.match!.startingHour);
      startingHour = widget.match!.startingHour.hourString;
      endingHour = widget.match!.endingHour.hourString;
      if (blocked && widget.match!.matchCreatorFirstName.isEmpty) {
        title = "Horário Bloqueado";
        subtitle = widget.match!.blockedReason;
      } else {
        title = "Partida de ${widget.match!.matchCreatorName}";
        subtitle = widget.match!.sport!.description;
      }
    } else {
      blocked = widget.recurrentMatch!.blocked;
      canBlockUnblock = (widget.calendarType == CalendarType.RecurrentMatch);
      subtitle = widget.recurrentMatch!.sport!.description;
      startingHour = widget.recurrentMatch!.startingHour.hourString;
      endingHour = widget.recurrentMatch!.endingHour.hourString;
      if (blocked) {
        title = "Mensalista de ${widget.recurrentMatch!.blockedReason}";
      } else {
        title = "Mensalista de ${widget.recurrentMatch!.creatorName}";
      }
    }
    return LayoutBuilder(
      builder: (layourContext, layoutConstraints) {
        return InkWell(
          onTap: () {
            if (blocked == false) {
              widget.onTapMatch();
            }
          },
          mouseCursor: blocked == false
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
                  colors: blocked
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
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color:
                              blocked ? secondaryYellowDark : primaryDarkBlue,
                        ),
                      ),
                      Text(
                        "$startingHour - $endingHour",
                        style: TextStyle(color: textDarkGrey),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(color: textDarkGrey),
                      ),
                    ],
                  ),
                  if (isOnHover && blocked && canBlockUnblock)
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
                          padding:
                              EdgeInsets.all(layoutConstraints.maxHeight * 0.1),
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
                                      width: layoutConstraints.maxHeight * 0.1,
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
              )),
        );
      },
    );
  }
}
