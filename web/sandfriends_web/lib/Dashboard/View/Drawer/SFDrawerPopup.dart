import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SFDrawerPopup extends StatefulWidget {
  Function(int) onTap;
  bool showIcon;
  SFDrawerPopup({super.key, 
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
          value: -1,
          child: Row(
            children: [
              SvgPicture.asset(
                r'assets/icon/profile.svg',
                color: textDarkGrey,
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              const Text(
                'Meu perfil',
                style: TextStyle(
                  color: textDarkGrey,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: -2,
          child: Row(
            children: [
              SvgPicture.asset(
                r'assets/icon/help.svg',
                color: textDarkGrey,
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              const Text(
                'Ajuda',
                style: TextStyle(
                  color: textDarkGrey,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: -3,
          child: Row(
            children: [
              SvgPicture.asset(
                r'assets/icon/logout.svg',
                color: Colors.red,
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              const Text(
                'Sair',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        widget.onTap(value);
      },
    );
  }
}
