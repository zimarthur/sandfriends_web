import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/View/Mobile/CreateAccountWidgetMobile.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/View/Web/CreateAccountWidgetWeb.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';

import '../../../SharedComponents/View/SFLoading.dart';
import '../../../SharedComponents/View/SFMessageModal.dart';
import '../../../SharedComponents/View/SFStandardScreen.dart';
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
    return Scaffold(
      body: ChangeNotifierProvider<CreateAccountViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<CreateAccountViewModel>(
          builder: (context, viewModel, _) {
            return SFStandardScreen(
              pageStatus: viewModel.pageStatus,
              messageModalWidget: viewModel.messageModal,
              child: Responsive.isMobile(context)
                  ? CreateAccountWidgetMobile(
                      viewModel: viewModel,
                    )
                  : CreateAccountWidgetWeb(
                      viewModel: viewModel,
                    ),
            );
          },
        ),
      ),
    );
  }
}
