import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../View/Components/SF_Button.dart';
import '../../View/Components/SF_Textfield.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var loginViewModel = Provider.of<LoginViewModel>(context);

    return Container(
      padding: EdgeInsets.all(2 * defaultPadding),
      height: height * 0.8,
      width: width * 0.3 < 350 ? 350 : width * 0.3,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  r'assets/icon/full_logo_positive.svg',
                ),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SFTextField(
                      labelText: "Email",
                      pourpose: TextFieldPourpose.Email,
                      prefixIcon: SvgPicture.asset(r"assets/icon/email.svg"),
                      controller: loginViewModel.userController,
                      validator: (value) {},
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SFTextField(
                      controller: loginViewModel.passwordController,
                      labelText: "Senha",
                      prefixIcon: SvgPicture.asset(r"assets/icon/lock.svg"),
                      suffixIcon:
                          SvgPicture.asset(r"assets/icon/eye_closed.svg"),
                      suffixIconPressed:
                          SvgPicture.asset(r"assets/icon/eye_open.svg"),
                      pourpose: TextFieldPourpose.Password,
                      validator: (value) {},
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Provider.of<LoginViewModel>(context, listen: false)
                              .keepConnected = !Provider.of<LoginViewModel>(
                                  context,
                                  listen: false)
                              .keepConnected;
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                              activeColor: primaryBlue,
                              value: Provider.of<LoginViewModel>(context)
                                  .keepConnected,
                              onChanged: (value) {
                                setState(() {
                                  Provider.of<LoginViewModel>(context,
                                          listen: false)
                                      .keepConnected = value!;
                                });
                              }),
                          Text(
                            "Mantenha-me conectado",
                            style: TextStyle(color: textDarkGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2 * defaultPadding,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SFButton(
                      buttonLabel: "Entrar",
                      buttonType: ButtonType.Primary,
                      onTap: (() {
                        Provider.of<LoginViewModel>(context, listen: false)
                            .onTapLogin(context);
                      }),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loginViewModel.onTapForgotPassword();
                        });
                      },
                      child: Text(
                        "Esqueci minha senha",
                        style: TextStyle(
                            color: textDarkGrey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ainda não cadastrou sua quadra? "),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Cadastre já!",
                        style: TextStyle(color: textBlue),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
