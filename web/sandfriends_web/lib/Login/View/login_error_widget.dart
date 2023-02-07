import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../View/Components/SF_Button.dart';
import '../../View/Components/SF_Textfield.dart';

class LoginErrorWidget extends StatefulWidget {
  const LoginErrorWidget({super.key});

  @override
  State<LoginErrorWidget> createState() => _LoginErrorWidgetState();
}

class _LoginErrorWidgetState extends State<LoginErrorWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LoginViewModel loginViewModel = LoginViewModel();

    return Container(
      padding: EdgeInsets.all(2 * defaultPadding),
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
            r"assets/icon/sad_face.svg",
            height: 100,
          ),
          SizedBox(
            height: 2 * defaultPadding,
          ),
          Text(
            "Não foi possível enviar o e-mail",
            style: TextStyle(color: textBlack, fontSize: 24),
          ),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            "Por favor, tente novamente",
            style: TextStyle(color: textDarkGrey, fontSize: 16),
          ),
          SizedBox(
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
