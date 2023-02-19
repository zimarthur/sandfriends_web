import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/View/Drawer/drawer.dart';
import '../ViewModel/DashboardViewModel.dart';
import '../../Utils/Responsive.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardViewModel viewModel = DashboardViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SFDrawer(),
      onDrawerChanged: (isOpened) {
        Provider.of<DashboardViewModel>(context, listen: false).isDrawerOpened =
            isOpened;
      },
      key: viewModel.scaffoldKey,
      body: ChangeNotifierProvider<DashboardViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<DashboardViewModel>(
          builder: (context, viewModel, _) {
            return SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SFDrawer(),
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
                                  onPressed: context
                                      .read<DashboardViewModel>()
                                      .controlMenu,
                                )
                              : Container(),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(2 * defaultPadding),
                            child: Provider.of<DashboardViewModel>(context)
                                .currentDashboardWidget,
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
