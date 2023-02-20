import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFCard extends StatelessWidget {
  double height;
  double width;
  String title;
  Widget child;

  SFCard(
      {required this.height,
      required this.width,
      required this.title,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: divider, width: 2),
        color: secondaryPaper,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //     offset: Offset(0, 1), // changes position of shadow
        //   ),
        // ],
      ),
      height: height,
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(defaultPadding / 2),
            decoration: BoxDecoration(
              color: secondaryBack,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(defaultBorderRadius),
                topRight: Radius.circular(
                  defaultBorderRadius,
                ),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: textDarkGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width,
            height: 2,
            color: divider,
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
