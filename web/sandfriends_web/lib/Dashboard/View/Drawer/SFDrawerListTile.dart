import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/constants.dart';

class SFDrawerListTile extends StatelessWidget {
  SFDrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    this.isSelected = false,
    required this.fullSize,
  }) : super(key: key);

  final String title, svgSrc;
  bool isSelected, fullSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? primaryDarkBlue : primaryBlue,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: fullSize
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgSrc,
                  color: isSelected ? Colors.white : textLightGrey,
                  height: 16,
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : textLightGrey,
                    ),
                  ),
                )
              ],
            )
          : SvgPicture.asset(
              svgSrc,
              color: isSelected ? Colors.white : textLightGrey,
              height: 16,
            ),
    );
  }
}
