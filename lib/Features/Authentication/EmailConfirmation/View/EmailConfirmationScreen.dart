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
                      : viewModel.pageStatus == PageStatus.WARNING
                          ? viewModel.messageModal
                          : Container(
                              padding: const EdgeInsets.all(2 * defaultPadding),
                              width: Responsive.isMobile(context)
                                  ? width * 0.8
                                  : width * 0.3 < 350
                                      ? 350
                                      : width * 0.3,
                              decoration: BoxDecoration(
                                color: secondaryPaper,
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius),
                                border: Border.all(
                                  color: divider,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    viewModel.isStoreRequest
                                        ? r"assets/people/email_confirmation_store.svg"
                                        : r"assets/people/email_confirmation_user.svg",
                                    height: Responsive.isMobile(context)
                                        ? height * 0.4
                                        : 150,
                                  ),
                                  const SizedBox(
                                    height: 2 * defaultPadding,
                                  ),
                                  Text(
                                    "Sua conta foi verificada!",
                                    style: TextStyle(
                                        color: textBlack,
                                        fontSize: Responsive.isMobile(context)
                                            ? 18
                                            : 24),
                                  ),
                                  const SizedBox(
                                    height: defaultPadding / 2,
                                  ),
                                  Text(
                                    viewModel.isStoreRequest
                                        ? "Faça login e comece a gerenciar as partidas da quadra!"
                                        : "Entre no app e comece a agendar suas partidas",
                                    style: TextStyle(
                                      color: textDarkGrey,
                                      fontSize: Responsive.isMobile(context)
                                          ? 14
                                          : 16,
                                    ),
                                  ),
                                  if (viewModel.isStoreRequest)
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: defaultPadding * 2,
                                        ),
                                        SFButton(
                                          buttonLabel: "Login",
                                          buttonType: ButtonType.Primary,
                                          onTap: () =>
                                              viewModel.goToLogin(context),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
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
