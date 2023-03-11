import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCourtsTabSelector extends StatefulWidget {
  String title;
  bool isSelected;
  String? iconPath;
  VoidCallback onTap;

  MyCourtsTabSelector(
      {required this.title,
      required this.isSelected,
      this.iconPath,
      required this.onTap});

  @override
  State<MyCourtsTabSelector> createState() => _MyCourtsTabSelectorState();
}

class _MyCourtsTabSelectorState extends State<MyCourtsTabSelector> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: divider,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultBorderRadius),
            topRight: Radius.circular(defaultBorderRadius),
          ),
        ),
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 2, left: 2, right: 2),
          padding: EdgeInsets.symmetric(
              vertical: defaultPadding / 2, horizontal: defaultPadding),
          decoration: BoxDecoration(
            color: widget.isSelected ? secondaryPaper : secondaryBack,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(defaultBorderRadius),
              topRight: Radius.circular(defaultBorderRadius),
            ),
          ),
          child: Row(
            children: [
              if (widget.iconPath != null)
                Row(
                  children: [
                    SvgPicture.asset(
                      widget.iconPath!,
                      height: 20,
                      width: 20,
                      color: textDarkGrey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              Text(
                widget.title,
                style: TextStyle(
                  color: textDarkGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
