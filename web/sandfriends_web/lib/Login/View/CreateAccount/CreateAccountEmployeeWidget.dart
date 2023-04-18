import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../SharedComponents/View/SFButton.dart';
import '../../../SharedComponents/View/SFTextfield.dart';

class CreateAccountEmployeeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var loginViewModel = Provider.of<LoginViewModel>(context);

    return Container(
      padding: EdgeInsets.all(2 * defaultPadding),
      width: width * 0.4 < 350 ? 350 : width * 0.4,
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
            "Criar conta funcionário",
            style: TextStyle(color: textBlack, fontSize: 24),
          ),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            "Se você trabalha em algum estabelecimento parceiro do sandfriends, insira seu email para criar sua conta. Em seguida, a administração da quadra poderá adicionar você à equipe.",
            style: TextStyle(color: textDarkGrey, fontSize: 16),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          SFTextField(
              labelText: "Insira seu email",
              pourpose: TextFieldPourpose.Email,
              controller: Provider.of<LoginViewModel>(context, listen: false)
                  .createAccountEmployeeController,
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
                    .createAccountEmployee();
              },
            ),
          )
        ],
      ),
    );
  }
}
