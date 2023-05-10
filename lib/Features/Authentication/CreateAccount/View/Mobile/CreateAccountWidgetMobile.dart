import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Mobile/CreateAccountCourtWidgetMobile.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Mobile/CreateAccountOwnerWidgetMobile.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Web/CreateAccountCourtWidgetWeb.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Web/CreateAccountOwnerWidgetWeb.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../../SharedComponents/View/SFButton.dart';

class CreateAccountWidgetMobile extends StatefulWidget {
  CreateAccountViewModel viewModel;
  CreateAccountWidgetMobile({
    super.key,
    required this.viewModel,
  });

  @override
  State<CreateAccountWidgetMobile> createState() =>
      _CreateAccountWidgetMobileState();
}

class _CreateAccountWidgetMobileState extends State<CreateAccountWidgetMobile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      width: width * 0.9,
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
                ? CreateAccountCourtWidgetMobile(
                    viewModel: widget.viewModel,
                  )
                : CreateAccountOwnerWidgetMobile(
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
                    buttonType: widget.viewModel.buttonNextEnabled
                        ? ButtonType.Primary
                        : ButtonType.Disabled,
                    onTap: () {
                      widget.viewModel.nextForm(context);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
