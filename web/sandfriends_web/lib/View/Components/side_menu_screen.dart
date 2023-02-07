import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/View/Components/drawer_list_tile.dart';
import 'package:sandfriends_web/controllers/MenuController.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    MenuController menuController =
        Provider.of<MenuController>(context, listen: false);
    return Drawer(
      backgroundColor: primaryBlue,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SvgPicture.asset(
              r'assets/icon/full_logo_negative.svg',
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: divider,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuController.drawerItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      menuController.onTabClick(index);
                    },
                    child: DrawerListTile(
                      title: menuController.drawerItems[index].title,
                      svgSrc: menuController.drawerItems[index].icon,
                      isSelected:
                          index == menuController.indexSelectedDrawerTile
                              ? true
                              : false,
                      fullSize: false,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}