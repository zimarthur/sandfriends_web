import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/FormItem.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/ViewModel/SettingsViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/View/SFHeader.dart';

class BasicInfo extends StatefulWidget {
  SettingsViewModel viewModel;

  BasicInfo({required this.viewModel});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            FormItem(
              name: "Nome",
              controller: widget.viewModel.nameController,
              onChanged: (p0) => widget.viewModel.storeInfoChanged(context),
            ),
            FormItem(
              name: "Telefone da empresa",
              controller: widget.viewModel.telephoneController,
              onChanged: (p0) => widget.viewModel.storeInfoChanged(context),
            ),
            FormItem(
              name: "Telefone pessoal",
              controller: widget.viewModel.telephoneOwnerController,
              onChanged: (p0) => widget.viewModel.storeInfoChanged(context),
            ),
          ],
        ),
        SFDivider(),
        Column(
          children: [
            FormItem(
              name: "CEP",
              controller: widget.viewModel.cepController,
              hasSecondItem: true,
              secondName: "Bairro",
              secondController: widget.viewModel.neighbourhoodController,
              onChanged: (p0) => widget.viewModel.storeInfoChanged(context),
            ),
            FormItem(
              name: "Rua",
              controller: widget.viewModel.addressController,
              hasSecondItem: true,
              secondName: "N°",
              secondController: widget.viewModel.addressNumberController,
              onChanged: (p0) => widget.viewModel.storeInfoChanged(context),
            ),
            FormItem(
              name: "Cidade",
              controller: widget.viewModel.cityController,
              hasSecondItem: true,
              secondName: "Estado(UF)",
              secondController: widget.viewModel.stateController,
              onChanged: (p0) => widget.viewModel.storeInfoChanged(context),
            ),
          ],
        ),
        SFDivider(),
        FormItem(
          name: "Email",
          controller: widget.viewModel.emailController,
          onChanged: (p0) => widget.viewModel.storeInfoChanged(context),
          controllerEnabled: false,
          hasSecondItem: true,
          customWidget: Row(
            children: [
              Expanded(
                child: SFButton(
                  buttonLabel: "Alterar senha",
                  buttonType: ButtonType.Secondary,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
