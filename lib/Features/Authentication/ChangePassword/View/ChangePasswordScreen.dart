import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Mobile/CreateAccountWidgetMobile.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Web/CreateAccountWidgetWeb.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';

import '../../../../SharedComponents/View/SFLoading.dart';
import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../SharedComponents/View/SFStandardScreen.dart';
import '../../../../Utils/PageStatus.dart';
import '../ViewModel/ChangePasswordViewModel.dart';
import 'ChangePasswordWidget.dart';

class ChangePasswordScreen extends StatefulWidget {
  String token;
  bool isStoreRequest;

  ChangePasswordScreen({
    required this.token,
    required this.isStoreRequest,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final viewModel = ChangePasswordViewModel();

  @override
  void initState() {
    viewModel.init(context, widget.token, widget.isStoreRequest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<ChangePasswordViewModel>(
        builder: (context, viewModel, _) {
          return SFStandardScreen(
            pageStatus: viewModel.pageStatus,
            messageModalWidget: viewModel.messageModal,
            child: ChangePasswordWidget(
              viewModel: viewModel,
            ),
          );
        },
      ),
    );
  }
}
