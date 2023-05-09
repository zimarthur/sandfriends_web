import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../../SharedComponents/View/SFTextfield.dart';
import '../../ViewModel/CreateAccountViewModel.dart';

class CreateAccountOwnerWidgetWeb extends StatefulWidget {
  CreateAccountViewModel viewModel;
  CreateAccountOwnerWidgetWeb({
    super.key,
    required this.viewModel,
  });

  @override
  State<CreateAccountOwnerWidgetWeb> createState() =>
      _CreateAccountOwnerWidgetWebState();
}

class _CreateAccountOwnerWidgetWebState
    extends State<CreateAccountOwnerWidgetWeb> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Conte-nos mais sobre você",
                    style: TextStyle(color: textBlack, fontSize: 24),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SFTextField(
                            labelText: "Nome",
                            pourpose: TextFieldPourpose.Standard,
                            controller:
                                widget.viewModel.ownerFirstNameController,
                            validator: (_) {
                              return null;
                            }),
                      ),
                      SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                        child: SFTextField(
                            labelText: "Sobrenome",
                            pourpose: TextFieldPourpose.Standard,
                            controller:
                                widget.viewModel.ownerLastNameController,
                            validator: (_) {
                              return null;
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  SFTextField(
                      labelText: "Email",
                      pourpose: TextFieldPourpose.Standard,
                      controller: widget.viewModel.emailController,
                      validator: (_) {
                        return null;
                      }),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  !widget.viewModel.noCnpj
                      ? Column(
                          children: [
                            SFTextField(
                                labelText: "CPF",
                                pourpose: TextFieldPourpose.Standard,
                                controller: widget.viewModel.cpfController,
                                validator: (_) {
                                  return null;
                                }),
                            const SizedBox(
                              height: defaultPadding,
                            ),
                          ],
                        )
                      : Container(),
                  Row(
                    children: [
                      Expanded(
                        child: SFTextField(
                          labelText: "Telefone da Quadra",
                          pourpose: TextFieldPourpose.Numeric,
                          controller: widget.viewModel.telephoneController,
                          validator: (_) {
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                        child: SFTextField(
                          labelText: "Telefone Pessoal",
                          pourpose: TextFieldPourpose.Numeric,
                          controller: widget.viewModel.telephoneOwnerController,
                          validator: (_) {
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            activeColor: primaryBlue,
                            value: widget.viewModel.isAbove18,
                            onChanged: (value) {
                              setState(() {
                                widget.viewModel.isAbove18 = value!;
                              });
                            }),
                        RichText(
                          text: const TextSpan(
                            text: 'Declaro que tenho acima de 18 anos',
                            style: TextStyle(
                              color: textDarkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
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
            ],
          ),
        ),
      ],
    );
  }
}
