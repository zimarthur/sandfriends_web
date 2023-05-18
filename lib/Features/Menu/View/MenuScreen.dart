import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Menu/View/Drawer/SFDrawer.dart';
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
  final MenuProvider viewModel = MenuProvider();

  @override
  void initState() {
    viewModel.validateAuthentication(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const SFDrawer(),
      onDrawerChanged: (isOpened) {
        Provider.of<MenuProvider>(context, listen: false).isDrawerOpened =
            isOpened;
      },
      key: viewModel.scaffoldKey,
      body: ChangeNotifierProvider<MenuProvider>(
        create: (BuildContext context) => viewModel,
        child: Consumer<MenuProvider>(
          builder: (context, viewModel, _) {
            return SFStandardScreen(
              pageStatus: viewModel.pageStatus,
              messageModalWidget: viewModel.messageModal,
              modalFormWidget: viewModel.modalFormWidget,
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
                                  onPressed:
                                      context.read<MenuProvider>().controlMenu,
                                )
                              : Container(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2 * defaultPadding,
                                  vertical: defaultPadding),
                              child: Provider.of<MenuProvider>(context)
                                  .currentMenuWidget,
                            ),
                          )
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
