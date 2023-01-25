import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Resources/constants.dart';
import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: textDarkGrey,
              ),
              onPressed: context.read<MenuController>().controlMenu,
            ),
          if (!Responsive.isDesktop(context))
            Text(
              "Dashboard",
              style: titleStyle,
            ),
          Expanded(child: Container()),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: primaryBlue),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  child: SvgPicture.asset(
                    r'assets/icon/full_logo_negative.svg',
                  ),
                ),
                if (!Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(
                      "<Nome Quadra>",
                      style: TextStyle(color: primaryDarkBlue),
                    ),
                  ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
