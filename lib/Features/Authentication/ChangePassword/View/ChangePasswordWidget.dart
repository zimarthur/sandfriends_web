import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/ChangePassword/ViewModel/ChangePasswordViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../Utils/Validators.dart';

class ChangePasswordWidget extends StatefulWidget {
  ChangePasswordViewModel viewModel;
  ChangePasswordWidget({
    required this.viewModel,
  });

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      width: width * 0.4 < 350 ? 350 : width * 0.4,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Form(
        key: widget.viewModel.changePasswordFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Troque sua senha",
                style: TextStyle(color: textBlack, fontSize: 24),
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Text(
                "Redefina sua senha para continuar usando sandfriends.",
                style: TextStyle(color: textDarkGrey, fontSize: 16),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              SFTextField(
                controller: widget.viewModel.newPasswordController,
                labelText: "Senha",
                suffixIcon: SvgPicture.asset(r"assets/icon/eye_closed.svg"),
                suffixIconPressed:
                    SvgPicture.asset(r"assets/icon/eye_open.svg"),
                pourpose: TextFieldPourpose.Password,
                validator: (value) {
                  return passwordValidator(value);
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                controller: widget.viewModel.confirmNewPasswordController,
                labelText: "Confirme sua senha",
                suffixIcon: SvgPicture.asset(r"assets/icon/eye_closed.svg"),
                suffixIconPressed:
                    SvgPicture.asset(r"assets/icon/eye_open.svg"),
                pourpose: TextFieldPourpose.Password,
                validator: (value) {
                  if (widget.viewModel.newPasswordController.text !=
                      widget.viewModel.confirmNewPasswordController.text) {
                    return "As senhas não estão iguais";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.3 < 350 ? 35 : width * 0.03),
                child: SFButton(
                  buttonLabel: "Enviar",
                  buttonType: ButtonType.Primary,
                  onTap: () {
                    if (widget.viewModel.changePasswordFormKey.currentState
                            ?.validate() ==
                        true) {
                      widget.viewModel.changePassword(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
