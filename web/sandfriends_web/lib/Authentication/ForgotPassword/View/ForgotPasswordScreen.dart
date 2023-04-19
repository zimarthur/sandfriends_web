import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/ForgotPassword/View/ForgotPasswordWidget.dart';
import 'package:sandfriends_web/Authentication/ForgotPassword/ViewModel/ForgotPasswordViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../SharedComponents/View/SFLoading.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../Utils/PageStatus.dart';

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
            return SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: primaryBlue.withOpacity(0.4),
                    height: height,
                    width: width,
                    child: Center(
                      child: ForgotPasswordWidget(viewModel: viewModel),
                    ),
                  ),
                  viewModel.pageStatus != PageStatus.OK
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
