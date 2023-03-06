import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SFDrawerPopup extends StatefulWidget {
  Function(int) onTap;
  bool showIcon;
  SFDrawerPopup({
    required this.onTap,
    required this.showIcon,
  });

  @override
  State<SFDrawerPopup> createState() => _SFDrawerPopupState();
}

class _SFDrawerPopupState extends State<SFDrawerPopup> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      icon: widget.showIcon
          ? SvgPicture.asset(
              r'assets/icon/three_dots.svg',
              fit: BoxFit.scaleDown,
              color: secondaryPaper,
            )
          : Container(),
      tooltip: "",
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          child: Row(
            children: [
              SvgPicture.asset(
                r'assets/icon/profile.svg',
                color: textDarkGrey,
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Text(
                'Meu perfil',
                style: TextStyle(
                  color: textDarkGrey,
                ),
              ),
            ],
          ),
          value: -1,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              SvgPicture.asset(
                r'assets/icon/help.svg',
                color: textDarkGrey,
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Text(
                'Ajuda',
                style: TextStyle(
                  color: textDarkGrey,
                ),
              ),
            ],
          ),
          value: -2,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              SvgPicture.asset(
                r'assets/icon/logout.svg',
                color: Colors.red,
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Text(
                'Sair',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
          value: -3,
        ),
      ],
      onSelected: (value) {
        widget.onTap(value);
      },
    );
  }
}
