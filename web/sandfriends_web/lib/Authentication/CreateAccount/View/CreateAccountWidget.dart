import 'package:flutter/material.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/View/CreateAccountCourtWidget.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/View/CreateAccountOwnerWidget.dart';
import 'package:sandfriends_web/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:sandfriends_web/Authentication/Login/ViewModel/LoginViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';

import '../../../SharedComponents/View/SFButton.dart';

class CreateAccountWidget extends StatefulWidget {
  CreateAccountViewModel viewModel;
  CreateAccountWidget({
    required this.viewModel,
  });

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
            child: widget.viewModel.currentCreateAccountFormIndex == 0
                ? CreateAccountCourtWidget(
                    viewModel: widget.viewModel,
                  )
                : CreateAccountOwnerWidget(
                    viewModel: widget.viewModel,
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: SFButton(
                    buttonLabel: "Voltar",
                    buttonType: ButtonType.Secondary,
                    onTap: () {
                      widget.viewModel.returnForm(context);
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
                      widget.viewModel.nextForm();
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
              widget.viewModel.goToCreateAccountEmployee(context);
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
}
