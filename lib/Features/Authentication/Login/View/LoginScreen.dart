import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/Login/View/LoginWidget.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFLoading.dart';
import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../SharedComponents/View/SFStandardScreen.dart';
import '../ViewModel/LoginViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = LoginViewModel();

  @override
  void initState() {
    //viewModel.validateToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<LoginViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, _) {
            return SFStandardScreen(
              pageStatus: viewModel.pageStatus,
              messageModalWidget: viewModel.messageModal,
              child: LoginWidget(
                viewModel: viewModel,
              ),
            );
          },
        ),
      ),
    );
  }
}
