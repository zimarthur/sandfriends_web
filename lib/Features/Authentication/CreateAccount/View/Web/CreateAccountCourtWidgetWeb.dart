import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Validators.dart';

import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';

class CreateAccountCourtWidgetWeb extends StatefulWidget {
  CreateAccountViewModel viewModel;
  CreateAccountCourtWidgetWeb({
    super.key,
    required this.viewModel,
  });

  @override
  State<CreateAccountCourtWidgetWeb> createState() =>
      _CreateAccountCourtWidgetWebState();
}

class _CreateAccountCourtWidgetWebState
    extends State<CreateAccountCourtWidgetWeb> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Form(
            key: widget.viewModel.courtFormKey,
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
                    widget.viewModel.noCnpj
                        ? SFTextField(
                            labelText: "CPF",
                            pourpose: TextFieldPourpose.Numeric,
                            controller: widget.viewModel.cpfController,
                            validator: (value) => cpfValidator(value),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: SFTextField(
                                  enable: !widget.viewModel.noCnpj,
                                  labelText: "CNPJ",
                                  pourpose: TextFieldPourpose.Numeric,
                                  controller: widget.viewModel.cnpjController,
                                  validator: (value) => cnpjValidator(value),
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
                                    widget.viewModel.onTapSearchCnpj();
                                  })
                            ],
                          ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: primaryBlue,
                            value: widget.viewModel.noCnpj,
                            onChanged: (value) {
                              setState(() {
                                widget.viewModel.noCnpj = value!;
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
                  margin:
                      const EdgeInsets.symmetric(vertical: defaultPadding * 2),
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
                        controller: widget.viewModel.storeNameController,
                        validator: (value) => emptyCheck(
                          value,
                          "digite o nome do estabelecimento",
                        ),
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
                        controller: widget.viewModel.cepController,
                        validator: (value) => cepValidator(value),
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
                        labelText: "Estado(UF)",
                        pourpose: TextFieldPourpose.Standard,
                        controller: widget.viewModel.stateController,
                        validator: (value) => lettersValidator(
                          value,
                          "digite o estado",
                        ),
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
                        controller: widget.viewModel.cityController,
                        validator: (value) => emptyCheck(
                          value,
                          "digite a cidade",
                        ),
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
                        controller: widget.viewModel.neighbourhoodController,
                        validator: (value) => emptyCheck(
                          value,
                          "digite o bairro",
                        ),
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
                        controller: widget.viewModel.addressController,
                        validator: (value) => emptyCheck(
                          value,
                          "digite a rua",
                        ),
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
                        controller: widget.viewModel.addressNumberController,
                        validator: (value) => emptyCheck(
                          value,
                          "digite o número",
                        ),
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
        ),
      ],
    );
  }
}
