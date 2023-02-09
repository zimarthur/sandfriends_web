import 'package:flutter/material.dart';
import 'package:sandfriends_web/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/View/Components/SF_Button.dart';
import 'package:sandfriends_web/View/Components/SF_Textfield.dart';
import 'package:sandfriends_web/constants.dart';
import 'package:provider/provider.dart';

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
      padding: EdgeInsets.all(2 * defaultPadding),
      height: height * 0.85,
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
              SFButton(
                  buttonLabel: "Voltar",
                  buttonType: ButtonType.Secondary,
                  onTap: () {
                    Provider.of<LoginViewModel>(context, listen: false)
                        .returnForm();
                  }),
              SFButton(
                  buttonLabel: "Próximo",
                  buttonType: ButtonType.Primary,
                  onTap: () {
                    Provider.of<LoginViewModel>(context, listen: false)
                        .nextForm();
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget CreateAccountOwnerForm = Column();
}
