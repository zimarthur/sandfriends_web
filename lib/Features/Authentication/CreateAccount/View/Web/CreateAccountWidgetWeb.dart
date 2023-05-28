import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Web/CreateAccountCourtWidgetWeb.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/View/Web/CreateAccountOwnerWidgetWeb.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../../SharedComponents/View/SFButton.dart';

class CreateAccountWidgetWeb extends StatefulWidget {
  CreateAccountViewModel viewModel;
  CreateAccountWidgetWeb({
    super.key,
    required this.viewModel,
  });

  @override
  State<CreateAccountWidgetWeb> createState() => _CreateAccountWidgetWebState();
}

class _CreateAccountWidgetWebState extends State<CreateAccountWidgetWeb> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      height: height * 0.85 > 600 ? 600 : height * 0.85,
      width: width * 0.65 < 450
          ? 450
          : width * 0.65 > 800
              ? 800
              : width * 0.65,
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
                ? CreateAccountCourtWidgetWeb(
                    viewModel: widget.viewModel,
                  )
                : CreateAccountOwnerWidgetWeb(
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
                    buttonLabel:
                        widget.viewModel.currentCreateAccountFormIndex == 0
                            ? "Próximo"
                            : "Finalizar",
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
