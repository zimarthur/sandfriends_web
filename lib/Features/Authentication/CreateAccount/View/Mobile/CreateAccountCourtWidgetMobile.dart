import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/CreateAccount/ViewModel/CreateAccountViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';

class CreateAccountCourtWidgetMobile extends StatefulWidget {
  CreateAccountViewModel viewModel;
  CreateAccountCourtWidgetMobile({
    super.key,
    required this.viewModel,
  });

  @override
  State<CreateAccountCourtWidgetMobile> createState() =>
      _CreateAccountCourtWidgetMobileState();
}

class _CreateAccountCourtWidgetMobileState
    extends State<CreateAccountCourtWidgetMobile> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: TextStyle(
                      color: textDarkGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Column(
                children: [
                  SFTextField(
                    labelText: widget.viewModel.noCnpj ? "CPF" : "CNPJ",
                    pourpose: TextFieldPourpose.Numeric,
                    controller: widget.viewModel.noCnpj
                        ? widget.viewModel.cpfController
                        : widget.viewModel.cnpjController,
                    validator: (_) {
                      return null;
                    },
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
                  widget.viewModel.noCnpj
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(
                              height: defaultPadding / 2,
                            ),
                            SFButton(
                              buttonLabel: "Buscar",
                              buttonType: ButtonType.Primary,
                              textPadding: const EdgeInsets.symmetric(
                                  horizontal: 2 * defaultPadding,
                                  vertical: defaultPadding),
                              onTap: () {
                                widget.viewModel.onTapSearchCnpj();
                              },
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
              SFTextField(
                labelText: "Nome do Estabelecimento",
                pourpose: TextFieldPourpose.Standard,
                controller: widget.viewModel.storeNameController,
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "CEP",
                pourpose: TextFieldPourpose.Standard,
                controller: widget.viewModel.cepController,
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "Estado(UF)",
                pourpose: TextFieldPourpose.Standard,
                controller: widget.viewModel.stateController,
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "Cidade",
                pourpose: TextFieldPourpose.Standard,
                controller: widget.viewModel.cityController,
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "Bairro",
                pourpose: TextFieldPourpose.Standard,
                controller: widget.viewModel.neighbourhoodController,
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "Rua",
                pourpose: TextFieldPourpose.Standard,
                controller: widget.viewModel.addressController,
                validator: (_) {
                  return null;
                },
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SFTextField(
                labelText: "Nº",
                pourpose: TextFieldPourpose.Standard,
                controller: widget.viewModel.addressNumberController,
                validator: (_) {
                  return null;
                },
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
