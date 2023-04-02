import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FinanceKpi extends StatelessWidget {
  String title;
  String value;
  String iconPath;
  Color iconColor;
  Color iconColorBackground;

  FinanceKpi({
    required this.title,
    required this.value,
    required this.iconPath,
    required this.iconColor,
    required this.iconColorBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
        color: secondaryPaper,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(
              defaultPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              color: iconColorBackground,
            ),
            child: SvgPicture.asset(
              iconPath,
              color: iconColor,
              height: 30,
              width: 30,
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: textDarkGrey, fontSize: 12),
              ),
              SizedBox(
                height: defaultPadding / 2,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
