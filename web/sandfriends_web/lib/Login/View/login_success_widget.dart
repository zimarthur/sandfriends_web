import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/Utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../SharedComponents/SF_Button.dart';
import '../../SharedComponents/SF_Textfield.dart';

class LoginSuccessWidget extends StatefulWidget {
  const LoginSuccessWidget({super.key});

  @override
  State<LoginSuccessWidget> createState() => _LoginSuccessWidgetState();
}

class _LoginSuccessWidgetState extends State<LoginSuccessWidget> {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            r"assets/icon/happy_face.svg",
            height: 100,
          ),
          const SizedBox(
            height: 2 * defaultPadding,
          ),
          const Text(
            "Email enviado!",
            style: TextStyle(color: textBlack, fontSize: 24),
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          const Text(
            "Verifique sua caixa de email e crie uma nova senha",
            style: TextStyle(color: textDarkGrey, fontSize: 16),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.3 < 350 ? 35 : width * 0.03),
            child: SFButton(
                buttonLabel: "Voltar",
                buttonType: ButtonType.Primary,
                onTap: () {
                  Provider.of<LoginViewModel>(context, listen: false)
                      .onTapGoToLoginWidget();
                }),
          )
        ],
      ),
    );
  }
}
