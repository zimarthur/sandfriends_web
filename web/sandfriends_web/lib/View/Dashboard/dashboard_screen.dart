import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Resources/constants.dart';
import 'package:provider/provider.dart';

import '../../controllers/MenuController.dart';
import '../../responsive.dart';
import 'header.dart';
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
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Container(
                color: secondaryBack,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Header(),
                    ),
                    Expanded(
                        child: Provider.of<MenuController>(context)
                            .currentDashboardWidget)
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
