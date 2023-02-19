import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/Utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../SharedComponents/SFButton.dart';
import '../../SharedComponents/SFTextfield.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Provider.of<LoginViewModel>(context, listen: false)
                .onTapGoToLoginWidget(),
            child: SvgPicture.asset(
              r"assets/icon/arrow_left.svg",
              height: 25,
            ),
          ),
          SizedBox(
            height: 2 * defaultPadding,
          ),
          Text(
            "Informe seu e-mail",
            style: TextStyle(color: textBlack, fontSize: 24),
          ),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            "Enviaremos um e-mail com um link para criar uma nova senha!",
            style: TextStyle(color: textDarkGrey, fontSize: 16),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          SFTextField(
              labelText: "",
              pourpose: TextFieldPourpose.Email,
              controller: Provider.of<LoginViewModel>(context, listen: false)
                  .forgotPasswordEmailController,
              validator: ((value) {})),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.3 < 350 ? 35 : width * 0.03),
            child: SFButton(
              buttonLabel: "Enviar",
              buttonType: ButtonType.Primary,
              onTap: () {
                Provider.of<LoginViewModel>(context, listen: false)
                    .sendForgotPassword();
              },
            ),
          )
        ],
      ),
    );
  }
}
