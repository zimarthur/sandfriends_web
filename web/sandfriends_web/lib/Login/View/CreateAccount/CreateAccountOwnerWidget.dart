import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../SharedComponents/SFTextfield.dart';
import '../../ViewModel/LoginViewModel.dart';

class CreateAccountOwnerWidget extends StatefulWidget {
  const CreateAccountOwnerWidget({super.key});

  @override
  State<CreateAccountOwnerWidget> createState() =>
      _CreateAccountOwnerWidgetState();
}

class _CreateAccountOwnerWidgetState extends State<CreateAccountOwnerWidget> {
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
                  SFTextField(
                      labelText: "Nome",
                      pourpose: TextFieldPourpose.Standard,
                      controller: Provider.of<LoginViewModel>(context)
                          .ownerNameController,
                      validator: (_) {}),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  SFTextField(
                      labelText: "Email",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context).emailController,
                      validator: (_) {}),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  !Provider.of<LoginViewModel>(context).noCnpj
                      ? Column(
                          children: [
                            SFTextField(
                                labelText: "CPF",
                                pourpose: TextFieldPourpose.Standard,
                                controller: Provider.of<LoginViewModel>(context)
                                    .cpfController,
                                validator: (_) {}),
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
                          controller: Provider.of<LoginViewModel>(context)
                              .telephoneController,
                          validator: (_) {},
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Expanded(
                        child: SFTextField(
                          labelText: "Telefone Pessoal",
                          pourpose: TextFieldPourpose.Numeric,
                          controller: Provider.of<LoginViewModel>(context)
                              .telephoneOwnerController,
                          validator: (_) {},
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
                            value:
                                Provider.of<LoginViewModel>(context).isAbove18,
                            onChanged: (value) {
                              setState(() {
                                Provider.of<LoginViewModel>(context,
                                        listen: false)
                                    .isAbove18 = value!;
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
                            value:
                                Provider.of<LoginViewModel>(context).termsAgree,
                            onChanged: (value) {
                              setState(() {
                                Provider.of<LoginViewModel>(context,
                                        listen: false)
                                    .termsAgree = value!;
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
                                      Provider.of<LoginViewModel>(context,
                                              listen: false)
                                          .onTapCreateAccount();
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
                                      Provider.of<LoginViewModel>(context,
                                              listen: false)
                                          .onTapCreateAccount();
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
