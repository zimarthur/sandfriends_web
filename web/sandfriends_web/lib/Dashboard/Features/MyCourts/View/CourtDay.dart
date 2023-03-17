import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourtDay extends StatefulWidget {
  double width;
  double height;
  CourtDay({
    required this.width,
    required this.height,
  });

  @override
  State<CourtDay> createState() => _CourtDayState();
}

class _CourtDayState extends State<CourtDay> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isExpanded ? 3 * widget.height : widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: primaryBlue),
      padding: EdgeInsets.all(2),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: isExpanded ? 3 * widget.height : widget.height,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      color: secondaryPaper,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Segunda",
                            style: TextStyle(color: textDarkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "08:00 - 22:00",
                            style: TextStyle(color: textDarkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Sim",
                            style: TextStyle(color: textDarkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "R\$100 - R\$120\n(R\$90 - R\$110)",
                            style: TextStyle(color: textDarkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isExpanded
                    ? Container()
                    : InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: SizedBox(
                          width: 50,
                          child: SvgPicture.asset(
                            r'assets/icon/edit.svg',
                            color: Colors.white,
                            height: 16,
                          ),
                        ),
                      )
              ],
            ),
          ),
          isExpanded
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: SizedBox(
                    width: 30,
                    child: SvgPicture.asset(
                      r'assets/icon/chevron_up.svg',
                      color: Colors.white,
                      height: 16,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
