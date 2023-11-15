import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccountEmployee/ViewModel/CreateAccountEmployeeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFStandardScreen.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';
import '../../../../SharedComponents/View/SFLoading.dart';
import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import 'CreateAccountEmployeeWidget.dart';

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
    viewModel.initCreateAccountEmployeeViewModel(context, widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider<CreateAccountEmployeeViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<CreateAccountEmployeeViewModel>(
        builder: (context, viewModel, _) {
          return SFStandardScreen(
            pageStatus: viewModel.pageStatus,
            childWeb: CreateAccountEmployeeWidget(
              viewModel: viewModel,
            ),
            childMobile: CreateAccountEmployeeWidget(
              viewModel: viewModel,
            ),
            messageModalWidget: viewModel.messageModal,
          );
        },
      ),
    );
  }
}
