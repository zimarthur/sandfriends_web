import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Menu/View/Drawer/SFDrawerUserWidget.dart';
import 'package:sandfriends_web/Menu/View/Drawer/SFDrawerListTile.dart';

import '../../../Utils/Responsive.dart';
import '../../ViewModel/MenuProvider.dart';
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
    MenuProvider menuController = Provider.of<MenuProvider>(context);
    bool fullSize =
        !Responsive.isMobile(context) && menuController.isDrawerExpanded ||
            Responsive.isMobile(context);
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
            width: fullSize ? 250 : 82,
            height: height,
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Responsive.isMobile(context) == false
                    ? InkWell(
                        onTap: () => menuController.isDrawerExpanded =
                            !menuController.isDrawerExpanded,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          alignment: fullSize
                              ? Alignment.centerRight
                              : Alignment.center,
                          child: SvgPicture.asset(
                            fullSize
                                ? r'assets/icon/double_arrow_left.svg'
                                : r'assets/icon/double_arrow_right.svg',
                            height: 25,
                            width: 25,
                            color: secondaryPaper,
                          ),
                        ),
                      )
                    : Container(),
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
                const SFDrawerDivider(),
                SFDrawerUserWidget(
                  fullSize: fullSize,
                  onTap: (value) {
                    menuController.onTabClick(value);
                  },
                )
              ],
            ),
          );
  }
}
