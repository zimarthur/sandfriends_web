import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Utils/Validators.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../SharedComponents/View/SFButton.dart';
import '../../../SharedComponents/View/SFTextfield.dart';
import '../ViewModel/CreateAccountEmployeeViewModel.dart';

class CreateAccountEmployeeWidgetMobile extends StatefulWidget {
  CreateAccountEmployeeViewModel viewModel;
  CreateAccountEmployeeWidgetMobile({
    super.key,
    required this.viewModel,
  });
  @override
  State<CreateAccountEmployeeWidgetMobile> createState() =>
      _CreateAccountEmployeeWidgetMobileState();
}

class _CreateAccountEmployeeWidgetMobileState
    extends State<CreateAccountEmployeeWidgetMobile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      width: width * 0.9,
      height: height * 0.9,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Form(
        key: widget.viewModel.createAccountEmployeeFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Seja bem vindo ao sandfriends!",
                style: TextStyle(color: textBlack, fontSize: 24),
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Text(
                "Você foi adicionado à equipe do ${widget.viewModel.storeName}. Preencha suas informações e comece a usar a plataforma.",
                style: TextStyle(color: textDarkGrey, fontSize: 16),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Email:",
                    style: TextStyle(
                      color: textDarkGrey,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      widget.viewModel.email,
                      minFontSize: 8,
                      maxFontSize: 18,
                      maxLines: 1,
                      style: const TextStyle(
                        color: textBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "Nome",
                pourpose: TextFieldPourpose.Email,
                controller:
                    widget.viewModel.createAccountEmployeeFirstNameController,
                validator: ((value) {
                  return emptyCheck(value, "Informe seu nome");
                }),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "Sobrenome",
                pourpose: TextFieldPourpose.Email,
                controller:
                    widget.viewModel.createAccountEmployeeLastNameController,
                validator: ((value) {
                  return emptyCheck(value, "Informe seu sobrenome");
                }),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                controller:
                    widget.viewModel.createAccountEmployeePasswordController,
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
                controller: widget
                    .viewModel.createAccountEmployeePasswordConfirmController,
                labelText: "Confirme sua senha",
                suffixIcon: SvgPicture.asset(r"assets/icon/eye_closed.svg"),
                suffixIconPressed:
                    SvgPicture.asset(r"assets/icon/eye_open.svg"),
                pourpose: TextFieldPourpose.Password,
                validator: (value) {
                  if (widget.viewModel.createAccountEmployeePasswordController
                          .text !=
                      widget
                          .viewModel
                          .createAccountEmployeePasswordConfirmController
                          .text) {
                    return "As senhas não estão iguais";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                            activeColor: primaryBlue,
                            value: widget.viewModel.isAbove18,
                            onChanged: (value) {
                              setState(() {
                                widget.viewModel.isAbove18 = value!;
                              });
                            }),
                        Flexible(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Declaro que tenho acima de 18 anos',
                              style: TextStyle(
                                color: textDarkGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding / 2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                            activeColor: primaryBlue,
                            value: widget.viewModel.termsAgree,
                            onChanged: (value) {
                              setState(() {
                                widget.viewModel.termsAgree = value!;
                              });
                            }),
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              text: 'Li e concordo com os ',
                              style: const TextStyle(
                                color: textDarkGrey,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Termos de Uso ',
                                  style: const TextStyle(
                                      color: textBlue,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      widget.viewModel
                                          .onTapTermosDeUso(context);
                                    },
                                ),
                                const TextSpan(
                                  text: 'e ',
                                ),
                                TextSpan(
                                  text: 'Política de Privacidade',
                                  style: const TextStyle(
                                      color: textBlue,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      widget.viewModel
                                          .onTapPoliticaDePrivacidade(context);
                                    },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.3 < 350 ? 35 : width * 0.03),
                child: SFButton(
                  buttonLabel: "Enviar",
                  buttonType: widget.viewModel.missingTerms()
                      ? ButtonType.Disabled
                      : ButtonType.Primary,
                  onTap: () {
                    if (!widget.viewModel.missingTerms()) {
                      if (widget.viewModel.createAccountEmployeeFormKey
                              .currentState
                              ?.validate() ==
                          true) {
                        widget.viewModel.createAccountEmployee(context);
                      }
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