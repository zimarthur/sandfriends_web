import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/ForgotPassword/ViewModel/ForgotPasswordViewModel.dart';
import 'package:sandfriends_web/Authentication/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../SharedComponents/View/SFButton.dart';
import '../../../SharedComponents/View/SFTextfield.dart';
import '../../../Utils/Validators.dart';

class ForgotPasswordWidget extends StatefulWidget {
  ForgotPasswordViewModel viewModel;
  ForgotPasswordWidget({
    super.key,
    required this.viewModel,
  });

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LoginViewModel loginViewModel = LoginViewModel();

    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      width: width * 0.3 < 350 ? 350 : width * 0.3,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Form(
        key: widget.viewModel.forgotPasswordFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => widget.viewModel.goToLogin(context),
              child: SvgPicture.asset(
                r"assets/icon/arrow_left.svg",
                height: 25,
              ),
            ),
            const SizedBox(
              height: 2 * defaultPadding,
            ),
            const Text(
              "Informe seu e-mail",
              style: TextStyle(color: textBlack, fontSize: 24),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            const Text(
              "Enviaremos um e-mail com um link para criar uma nova senha!",
              style: TextStyle(color: textDarkGrey, fontSize: 16),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            SFTextField(
              labelText: "",
              pourpose: TextFieldPourpose.Email,
              controller: widget.viewModel.forgotPasswordEmailController,
              validator: ((value) {
                return emailValidator(value);
              }),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.3 < 350 ? 35 : width * 0.03),
              child: SFButton(
                buttonLabel: "Enviar",
                buttonType: ButtonType.Primary,
                onTap: () {
                  if (widget.viewModel.forgotPasswordFormKey.currentState
                          ?.validate() ==
                      true) {
                    widget.viewModel.sendForgotPassword(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
