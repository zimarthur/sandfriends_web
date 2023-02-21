import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/View/Drawer/SFDrawer.dart';
import '../../SharedComponents/View/SFLoading.dart';
import '../../SharedComponents/View/SFMessageModal.dart';
import '../../Utils/PageStatus.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              child: Stack(
                children: [
                  Row(
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2 * defaultPadding,
                                    vertical: defaultPadding),
                                child: Provider.of<DashboardViewModel>(context)
                                    .currentDashboardWidget,
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  viewModel.pageStatus != PageStatus.SUCCESS
                      ? Container(
                          color: primaryBlue.withOpacity(0.4),
                          height: height,
                          width: width,
                          child: Center(
                              child: viewModel.pageStatus == PageStatus.LOADING
                                  ? Container(
                                      height: 300,
                                      width: 300,
                                      child: SFLoading(size: 80),
                                    )
                                  : viewModel.pageStatus == PageStatus.FORM
                                      ? viewModel.modalFormWidget
                                      : SFMessageModal(
                                          title: viewModel.modalTitle,
                                          description:
                                              viewModel.modalDescription,
                                          onTap: viewModel.modalCallback,
                                          isHappy: viewModel.pageStatus ==
                                                  PageStatus.ERROR
                                              ? false
                                              : true,
                                        )),
                        )
                      : Container(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
