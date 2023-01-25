import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Resources/constants.dart';

class DrawerListTile extends StatelessWidget {
  DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    this.isSelected = false,
  }) : super(key: key);

  final String title, svgSrc;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isSelected ? primaryDarkBlue : primaryBlue,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: isSelected ? Colors.white : Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white54),
      ),
    );
  }
}
