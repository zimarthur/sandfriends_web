import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/View/Drawer/SFDrawerUserWidget.dart';
import 'package:sandfriends_web/Dashboard/View/Drawer/SFDrawerListTile.dart';

import '../../../Utils/Responsive.dart';
import '../../ViewModel/DashboardViewModel.dart';
import 'SFDrawerDivider.dart';

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
    DashboardViewModel menuController =
        Provider.of<DashboardViewModel>(context);
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
                const SFDrawerDivider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: menuController.drawerItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          menuController.onTabClick(index);
                        },
                        onHover: (value) {},
                        child: SFDrawerListTile(
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
                  child: SFDrawerListTile(
                    title: "Ajuda",
                    svgSrc: r"assets/icon/help.svg",
                    fullSize: fullSize,
                    isSelected: false,
                  ),
                ),
                const SFDrawerDivider(),
                SFDrawerUserWidget(fullSize: fullSize),
              ],
            ),
          );
  }
}
