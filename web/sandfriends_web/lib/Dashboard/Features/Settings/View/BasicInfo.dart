import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/FormItem.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/SettingsViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/View/SFHeader.dart';

Widget BasicInfo(SettingsViewModel viewModel) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          FormItem(
            name: "Nome",
            controller: viewModel.nameController,
          ),
          FormItem(
            name: "Telefone da empresa",
            controller: viewModel.telephoneController,
          ),
          FormItem(
            name: "Telefone pessoal",
            controller: viewModel.telephoneOwnerController,
          ),
        ],
      ),
      Container(
        width: double.infinity,
        height: 1,
        color: divider,
        margin: EdgeInsets.symmetric(vertical: defaultPadding),
      ),
      Column(
        children: [
          FormItem(
            name: "CEP",
            controller: viewModel.cepController,
            hasSecondItem: true,
            secondName: "Bairro",
            secondController: viewModel.neighbourhoodController,
          ),
          FormItem(
            name: "Rua",
            controller: viewModel.addressController,
            hasSecondItem: true,
            secondName: "N°",
            secondController: viewModel.addressNumberController,
          ),
          FormItem(
            name: "Cidade",
            controller: viewModel.cityController,
            hasSecondItem: true,
            secondName: "Estado(UF)",
            secondController: viewModel.stateController,
          ),
        ],
      ),
      Container(
        width: double.infinity,
        height: 1,
        color: divider,
        margin: EdgeInsets.symmetric(vertical: defaultPadding),
      ),
      FormItem(
        name: "Email",
        controller: viewModel.emailController,
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
