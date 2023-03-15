import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class CourtDay extends StatelessWidget {
  double width;
  double height;
  CourtDay({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryBlue,
            secondaryBack,
          ],
        ),
      ),
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "SEGUNDA",
            style: TextStyle(color: textWhite, fontSize: 16),
          ),
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                color: secondaryPaper),
            child: Column(
              children: [
                Text(
                  "Horário",
                  style: TextStyle(color: textLightGrey, fontSize: 10),
                ),
                Text(
                  "08:00 - 22:00",
                  style: TextStyle(color: textDarkGrey, fontSize: 12),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "Preço",
                  style: TextStyle(color: textLightGrey, fontSize: 10),
                ),
                Text(
                  r"R$80 - R$110",
                  style: TextStyle(color: textDarkGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
