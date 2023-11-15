import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Menu/View/Mobile/MenuWidgetMobile.dart';
import 'package:sandfriends_web/Features/Menu/View/Mobile/Header.dart';
import 'package:sandfriends_web/Features/Menu/View/Web/MenuWidgetWeb.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Menu/View/Mobile/DrawerMobile/SFDrawer.dart';
import '../../../SharedComponents/View/SFLoading.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../SharedComponents/View/SFStandardScreen.dart';
import '../../../Utils/PageStatus.dart';
import '../ViewModel/MenuProvider.dart';
import '../../../Utils/Responsive.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final viewModel = MenuProvider();

  @override
  void initState() {
    viewModel.validateAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuProvider>(
      create: (BuildContext context) => viewModel,
      child: Consumer<MenuProvider>(
        builder: (context, viewModel, _) {
          return SFStandardScreen(
            drawer: SFDrawer(
              viewModel: viewModel,
            ),
            // onDrawerChanged: (isOpened) {
            //   Provider.of<MenuProvider>(context, listen: false).isDrawerOpened =
            //       isOpened;
            // },
            scaffoldKey: viewModel.scaffoldKey,
            pageStatus: viewModel.pageStatus,
            messageModalWidget: viewModel.messageModal,
            modalFormWidget: viewModel.modalFormWidget,
            childWeb: MenuWidgetWeb(viewModel: viewModel),
            childMobile: MenuWidgetMobile(viewModel: viewModel),
          );
        },
      ),
    );
  }
}
