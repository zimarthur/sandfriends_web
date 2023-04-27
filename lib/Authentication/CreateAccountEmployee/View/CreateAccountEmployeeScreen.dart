import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccountEmployee/View/CreateAccountEmployeeWidgetMobile.dart';
import 'package:sandfriends_web/Authentication/CreateAccountEmployee/View/CreateAccountEmployeeWidgetWeb.dart';
import 'package:sandfriends_web/Authentication/CreateAccountEmployee/ViewModel/CreateAccountEmployeeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFStandardScreen.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';
import 'dart:html';
import '../../../SharedComponents/View/SFLoading.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../Utils/PageStatus.dart';

class CreateAccountEmployeeScreen extends StatefulWidget {
  String token;
  CreateAccountEmployeeScreen({
    required this.token,
  });

  @override
  State<CreateAccountEmployeeScreen> createState() =>
      _CreateAccountEmployeeScreenState();
}

class _CreateAccountEmployeeScreenState
    extends State<CreateAccountEmployeeScreen> {
  final viewModel = CreateAccountEmployeeViewModel();

  @override
  void initState() {
    viewModel.addEmployeeToken = widget.token;
    viewModel.initCreateAccountEmployeeViewModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ChangeNotifierProvider<CreateAccountEmployeeViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<CreateAccountEmployeeViewModel>(
          builder: (context, viewModel, _) {
            return SFStandardScreen(
              pageStatus: viewModel.pageStatus,
              child: Responsive.isMobile(context)
                  ? CreateAccountEmployeeWidgetMobile(
                      viewModel: viewModel,
                    )
                  : CreateAccountEmployeeWidgetWeb(
                      viewModel: viewModel,
                    ),
              messageModalWidget: viewModel.messageModal,
            );
          },
        ),
      ),
    );
  }
}
