import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccountEmployee/View/CreateAccountEmployeeWidget.dart';
import 'package:sandfriends_web/Authentication/CreateAccountEmployee/ViewModel/CreateAccountEmployeeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../SharedComponents/View/SFLoading.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../Utils/PageStatus.dart';

class CreateAccountEmployeeScreen extends StatefulWidget {
  const CreateAccountEmployeeScreen({super.key});

  @override
  State<CreateAccountEmployeeScreen> createState() =>
      _CreateAccountEmployeeScreenState();
}

class _CreateAccountEmployeeScreenState
    extends State<CreateAccountEmployeeScreen> {
  final viewModel = CreateAccountEmployeeViewModel();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ChangeNotifierProvider<CreateAccountEmployeeViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<CreateAccountEmployeeViewModel>(
          builder: (context, viewModel, _) {
            return SafeArea(
              child: Stack(
                children: [
                  Container(
                    color: primaryBlue.withOpacity(0.4),
                    height: height,
                    width: width,
                    child: Center(
                      child: CreateAccountEmployeeWidget(viewModel: viewModel),
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
