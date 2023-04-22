import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/Login/View/LoginWidget.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../SharedComponents/View/SFLoading.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
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
    viewModel.validateToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ChangeNotifierProvider<LoginViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<LoginViewModel>(
          builder: (context, viewModel, _) {
            return SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: primaryBlue.withOpacity(0.4),
                    height: height,
                    width: width,
                    child: Center(
                      child: LoginWidget(viewModel: viewModel),
                    ),
                  ),
                  viewModel.pageStatus != PageStatus.OK
                      ? Container(
                          color: primaryBlue.withOpacity(0.4),
                          height: height,
                          width: width,
                          child: Center(
                            child: viewModel.pageStatus == PageStatus.LOADING
                                ? SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: SFLoading(size: 80),
                                  )
                                : SFMessageModal(
                                    title: viewModel.modalTitle,
                                    description: viewModel.modalDescription,
                                    onTap: viewModel.modalCallback,
                                    isHappy:
                                        viewModel.pageStatus == PageStatus.ERROR
                                            ? false
                                            : true,
                                  ),
                          ),
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
