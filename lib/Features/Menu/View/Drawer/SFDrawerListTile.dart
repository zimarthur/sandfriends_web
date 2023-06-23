import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFDrawerListTile extends StatefulWidget {
  SFDrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.isSelected,
    required this.isHovered,
    required this.fullSize,
  }) : super(key: key);

  final String title, svgSrc;
  bool isSelected, fullSize, isHovered;

  @override
  State<SFDrawerListTile> createState() => _SFDrawerListTileState();
}

class _SFDrawerListTileState extends State<SFDrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.isSelected
            ? primaryDarkBlue
            : widget.isHovered
                ? primaryLightBlue.withOpacity(0.5)
                : primaryBlue,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      padding: const EdgeInsets.all(defaultPadding),
      child: widget.fullSize
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.svgSrc,
                  color: Colors.white,
                  height: 16,
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          : SvgPicture.asset(
              widget.svgSrc,
              color: Colors.white,
              height: 16,
            ),
    );
  }
}
