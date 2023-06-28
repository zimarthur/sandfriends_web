import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/Validators.dart';

import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFTextfield.dart';

class LoginWidget extends StatefulWidget {
  LoginViewModel viewModel;
  LoginWidget({
    super.key,
    required this.viewModel,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: 2 * defaultPadding),
      height: height * 0.9 > 750 ? 750 : height * 0.9,
      width: width * 0.3 < 350
          ? 350
          : width * 0.3 > 500
              ? 500
              : width * 0.3,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: widget.viewModel.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Image.asset(
                      r'assets/full_logo_positive_284.png',
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SFTextField(
                        labelText: "Email",
                        pourpose: TextFieldPourpose.Email,
                        prefixIcon: SvgPicture.asset(r"assets/icon/email.svg"),
                        controller: widget.viewModel.userController,
                        validator: (value) =>
                            emptyCheck(value, "Digite seu email"),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      SFTextField(
                        controller: widget.viewModel.passwordController,
                        labelText: "Senha",
                        prefixIcon: SvgPicture.asset(r"assets/icon/lock.svg"),
                        suffixIcon:
                            SvgPicture.asset(r"assets/icon/eye_closed.svg"),
                        suffixIconPressed:
                            SvgPicture.asset(r"assets/icon/eye_open.svg"),
                        pourpose: TextFieldPourpose.Password,
                        validator: (value) =>
                            emptyCheck(value, "Digite sua senha"),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      InkWell(
                        onTap: () => widget.viewModel.keepConnected =
                            !widget.viewModel.keepConnected,
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: primaryBlue,
                              value: widget.viewModel.keepConnected,
                              onChanged: (value) =>
                                  widget.viewModel.keepConnected = value!,
                            ),
                            const Text(
                              "Mantenha-me conectado",
                              style: TextStyle(color: textDarkGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2 * defaultPadding,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SFButton(
                        buttonLabel: "Entrar",
                        buttonType: ButtonType.Primary,
                        onTap: (() {
                          widget.viewModel.onTapLogin(context);
                        }),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            widget.viewModel.onTapForgotPassword(context);
                          });
                        },
                        child: const Text(
                          "Esqueci minha senha",
                          style: TextStyle(
                              color: textDarkGrey,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: 'Ainda não cadastrou sua quadra? ',
                        style: TextStyle(
                          color: textDarkGrey,
                          fontFamily: 'Lexend',
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Cadastre já!',
                            style: const TextStyle(
                                color: textBlue, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                widget.viewModel.onTapCreateAccount(context);
                              },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
