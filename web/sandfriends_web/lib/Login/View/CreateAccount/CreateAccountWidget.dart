import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';

import '../../../SharedComponents/View/SFButton.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({super.key});

  @override
  State<CreateAccountWidget> createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      height: height * 0.9,
      width: width * 0.5 < 350 ? 350 : width * 0.5,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
              child: Provider.of<LoginViewModel>(context).createAccountForm),
          Row(
            children: [
              Expanded(
                child: SFButton(
                    buttonLabel: "Voltar",
                    buttonType: ButtonType.Secondary,
                    onTap: () {
                      Provider.of<LoginViewModel>(context, listen: false)
                          .returnForm();
                    }),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: SFButton(
                    buttonLabel: "Próximo",
                    buttonType: ButtonType.Primary,
                    onTap: () {
                      Provider.of<LoginViewModel>(context, listen: false)
                          .nextForm();
                    }),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: Text(
              "ou",
              style: TextStyle(
                color: textDarkGrey,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<LoginViewModel>(context, listen: false)
                  .setCreateAccountEmployeeWidget();
            },
            child: Text(
              "Crie uma conta funcionário",
              style: TextStyle(
                  color: textBlue, decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  Widget CreateAccountOwnerForm = Column();
}
