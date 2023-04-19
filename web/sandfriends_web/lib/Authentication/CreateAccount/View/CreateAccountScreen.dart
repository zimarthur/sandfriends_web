import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/View/CreateAccountWidget.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../SharedComponents/View/SFLoading.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../Utils/PageStatus.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final viewModel = CreateAccountViewModel();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ChangeNotifierProvider<CreateAccountViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<CreateAccountViewModel>(
          builder: (context, viewModel, _) {
            return SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: primaryBlue.withOpacity(0.4),
                    height: height,
                    width: width,
                    child: Center(
                      child: CreateAccountWidget(viewModel: viewModel),
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
