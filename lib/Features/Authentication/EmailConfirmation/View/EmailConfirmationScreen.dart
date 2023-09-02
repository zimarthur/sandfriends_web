import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/EmailConfirmation/ViewModel/EmailConfirmationViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../SharedComponents/View/SFLoading.dart';
import '../../../../SharedComponents/View/SFMessageModal.dart';
import '../../../../Utils/PageStatus.dart';
import '../../../../Utils/Responsive.dart';
import 'EmailConfirmationWidget.dart';

class EmailConfirmationScreen extends StatefulWidget {
  String token;
  bool isStoreRequest;

  EmailConfirmationScreen({
    required this.token,
    required this.isStoreRequest,
  });

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  final viewModel = EmailConfirmationViewModel();

  @override
  void initState() {
    viewModel.initEmailConfirmationViewModel(
      context,
      widget.token,
      widget.isStoreRequest,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ChangeNotifierProvider<EmailConfirmationViewModel>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EmailConfirmationViewModel>(
          builder: (context, viewModel, _) {
            return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primaryBlue, primaryLightBlue])),
                height: height,
                width: width,
                child: Center(
                  child: viewModel.pageStatus == PageStatus.LOADING
                      ? SizedBox(
                          height: 300,
                          width: 300,
                          child: SFLoading(size: 80),
                        )
                      : viewModel.pageStatus == PageStatus.WARNING
                          ? viewModel.messageModal
                          : EmailConfirmationWidget(
                              viewModel: viewModel,
                            ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
