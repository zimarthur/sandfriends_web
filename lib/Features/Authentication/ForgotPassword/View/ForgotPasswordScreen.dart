import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/ForgotPassword/View/ForgotPasswordWidget.dart';
import 'package:sandfriends_web/Features/Authentication/ForgotPassword/ViewModel/ForgotPasswordViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFStandardScreen.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/View/SFLoading.dart';
import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final viewModel = ForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ChangeNotifierProvider<ForgotPasswordViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ForgotPasswordViewModel>(
          builder: (context, viewModel, _) {
            return SFStandardScreen(
              pageStatus: viewModel.pageStatus,
              messageModalWidget: viewModel.messageModal,
              child: ForgotPasswordWidget(
                viewModel: viewModel,
              ),
            );
          },
        ),
      ),
    );
  }
}
