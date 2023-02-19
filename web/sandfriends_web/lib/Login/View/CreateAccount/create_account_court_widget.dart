import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/SF_Button.dart';
import 'package:sandfriends_web/Utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../SharedComponents/SF_Textfield.dart';
import '../../ViewModel/LoginViewModel.dart';

class CreateAccountCourtWidget extends StatefulWidget {
  const CreateAccountCourtWidget({super.key});

  @override
  State<CreateAccountCourtWidget> createState() =>
      _CreateAccountCourtWidgetState();
}

class _CreateAccountCourtWidgetState extends State<CreateAccountCourtWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Cadastre seu estabelecimento!",
                style: TextStyle(color: textBlack, fontSize: 24),
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              const Text(
                "Você está a poucos cliques de gerenciar suas quadras com sandfriends!",
                style: TextStyle(color: textDarkGrey, fontSize: 16),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Column(
                children: [
                  Provider.of<LoginViewModel>(context).noCnpj
                      ? SFTextField(
                          labelText: "CPF",
                          pourpose: TextFieldPourpose.Numeric,
                          controller: Provider.of<LoginViewModel>(context)
                              .cpfController,
                          validator: (_) {})
                      : Row(
                          children: [
                            Expanded(
                              child: SFTextField(
                                enable: !Provider.of<LoginViewModel>(context)
                                    .noCnpj,
                                labelText: "CNPJ",
                                pourpose: TextFieldPourpose.Numeric,
                                controller: Provider.of<LoginViewModel>(context,
                                        listen: false)
                                    .cnpjController,
                                validator: (_) {},
                              ),
                            ),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            SFButton(
                                buttonLabel: "Buscar",
                                buttonType: ButtonType.Primary,
                                textPadding: const EdgeInsets.symmetric(
                                    horizontal: 2 * defaultPadding,
                                    vertical: defaultPadding),
                                onTap: () {
                                  Provider.of<LoginViewModel>(context,
                                          listen: false)
                                      .onTapSearchCnpj();
                                })
                          ],
                        ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: primaryBlue,
                          value: Provider.of<LoginViewModel>(context).noCnpj,
                          onChanged: (value) {
                            setState(() {
                              Provider.of<LoginViewModel>(context,
                                      listen: false)
                                  .noCnpj = value!;
                            });
                          }),
                      const Text(
                        "Não tenho CNPJ",
                        style: TextStyle(color: textDarkGrey),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
                width: double.infinity,
                height: 1,
                color: divider,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SFTextField(
                      labelText: "Nome do Estabelecimento",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context, listen: false)
                              .storeNameController,
                      validator: (_) {},
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 1,
                    child: SFTextField(
                      labelText: "CEP",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context, listen: false)
                              .cepController,
                      validator: (_) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(
                    child: SFTextField(
                      labelText: "Estado",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context, listen: false)
                              .stateController,
                      validator: (_) {},
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 2,
                    child: SFTextField(
                      labelText: "Cidade",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context, listen: false)
                              .cityController,
                      validator: (_) {},
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 2,
                    child: SFTextField(
                      labelText: "Bairro",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context, listen: false)
                              .neighbourhoodController,
                      validator: (_) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SFTextField(
                      labelText: "Rua",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context, listen: false)
                              .addressController,
                      validator: (_) {},
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    flex: 1,
                    child: SFTextField(
                      labelText: "Nº",
                      pourpose: TextFieldPourpose.Standard,
                      controller:
                          Provider.of<LoginViewModel>(context, listen: false)
                              .addressNumberController,
                      validator: (_) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2 * defaultPadding,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
