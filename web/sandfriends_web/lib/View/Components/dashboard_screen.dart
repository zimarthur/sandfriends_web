import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/View/Components/Drawer/drawer.dart';

import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import 'side_menu_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SFDrawer(),
      onDrawerChanged: (isOpened) {
        Provider.of<MenuController>(context, listen: false).isDrawerOpened =
            isOpened;
      },
      key: context.read<MenuController>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SFDrawer(),
            Expanded(
              flex: 5,
              child: Container(
                color: secondaryBack,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Responsive.isMobile(context)
                        ? IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: textDarkGrey,
                            ),
                            onPressed:
                                context.read<MenuController>().controlMenu,
                          )
                        : Container(),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(2 * defaultPadding),
                      child: Provider.of<MenuController>(context)
                          .currentDashboardWidget,
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
