import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class MyCourtsTabSelector extends StatefulWidget {
  String title;
  bool isSelected;

  MyCourtsTabSelector({required this.title, required this.isSelected});

  @override
  State<MyCourtsTabSelector> createState() => _MyCourtsTabSelectorState();
}

class _MyCourtsTabSelectorState extends State<MyCourtsTabSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            vertical: defaultPadding, horizontal: 2 * defaultPadding),
        decoration: BoxDecoration(
          color: widget.isSelected ? secondaryPaper : secondaryBack,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultBorderRadius),
            topRight: Radius.circular(defaultBorderRadius),
          ),
        ),
        child: Text(widget.title),
      ),
    );
  }
}
