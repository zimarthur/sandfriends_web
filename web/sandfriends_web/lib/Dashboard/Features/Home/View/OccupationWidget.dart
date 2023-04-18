import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class OccupationWidget extends StatelessWidget {
  String title;
  double result;

  OccupationWidget({
    required this.title,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, layoutConstraints) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: textDarkGrey, fontSize: 12),
                ),
              ),
              Text(
                "${(result * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                    color: textBlue, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Stack(
            children: [
              Container(
                width: layoutConstraints.maxWidth,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    defaultBorderRadius,
                  ),
                  color: divider,
                ),
              ),
              Container(
                width: layoutConstraints.maxWidth * result,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    defaultBorderRadius,
                  ),
                  color: primaryBlue,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
