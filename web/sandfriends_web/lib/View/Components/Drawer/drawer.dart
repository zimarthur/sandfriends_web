import 'package:flutter/material.dart';
import 'package:sandfriends_web/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/View/Components/Drawer/drawer_user_widget.dart';
import 'package:sandfriends_web/View/Components/drawer_list_tile.dart';
import 'package:sandfriends_web/controllers/MenuController.dart';

import '../../../responsive.dart';
import 'drawer_divider.dart';

class SFDrawer extends StatefulWidget {
  const SFDrawer({super.key});

  @override
  State<SFDrawer> createState() => _SFDrawerState();
}

class _SFDrawerState extends State<SFDrawer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MenuController menuController = Provider.of<MenuController>(context);
    bool fullSize =
        Responsive.isDesktop(context) || menuController.isDrawerOpened;
    return Responsive.isMobile(context) &&
            menuController.isDrawerOpened == false
        ? Container()
        : Container(
            decoration: const BoxDecoration(
              color: primaryBlue,
              border: Border(
                right: BorderSide(
                  color: primaryDarkBlue,
                  width: 1,
                ),
              ),
            ),
            width: fullSize ? 250 : 80,
            height: height,
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                SvgPicture.asset(
                  fullSize
                      ? r'assets/icon/full_logo_negative.svg'
                      : r'assets/icon/logo_negative.svg',
                  fit: BoxFit.fitWidth,
                ),
                SFDrawerDivider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: menuController.drawerItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          menuController.onTabClick(index);
                        },
                        onHover: (value) {},
                        child: DrawerListTile(
                          title: menuController.drawerItems[index].title,
                          svgSrc: menuController.drawerItems[index].icon,
                          isSelected:
                              index == menuController.indexSelectedDrawerTile
                                  ? true
                                  : false,
                          fullSize: fullSize,
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {},
                  onHover: (value) {},
                  child: DrawerListTile(
                    title: "Ajuda",
                    svgSrc: r"assets/icon/help.svg",
                    fullSize: fullSize,
                    isSelected: false,
                  ),
                ),
                SFDrawerDivider(),
                SFDrawerUserWidget(fullSize: fullSize),
              ],
            ),
          );
  }
}
