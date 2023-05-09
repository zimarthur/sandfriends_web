import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Settings/BasicInfo/ViewModel/BasicInfoViewModel.dart';
import 'package:sandfriends_web/Features/Settings/View/FormItem.dart';
import 'package:sandfriends_web/Features/Settings/ViewModel/SettingsViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class BasicInfo extends StatefulWidget {
  BasicInfoViewModel viewModel;

  BasicInfo({super.key, required this.viewModel});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Column(
                children: [
                  FormItem(
                    name: "Nome",
                    controller: widget.viewModel.nameController,
                    onChanged: (p0) {},
                  ),
                  FormItem(
                    name: "Telefone da empresa",
                    controller: widget.viewModel.telephoneController,
                    onChanged: (p0) {},
                  ),
                  FormItem(
                    name: "Telefone pessoal",
                    controller: widget.viewModel.telephoneOwnerController,
                    onChanged: (p0) {},
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: SFDivider(),
              ),
              Column(
                children: [
                  FormItem(
                    name: "CEP",
                    controller: widget.viewModel.cepController,
                    hasSecondItem: true,
                    secondName: "Bairro",
                    secondController: widget.viewModel.neighbourhoodController,
                    onChanged: (p0) {},
                  ),
                  FormItem(
                    name: "Rua",
                    controller: widget.viewModel.addressController,
                    hasSecondItem: true,
                    secondName: "N°",
                    secondController: widget.viewModel.addressNumberController,
                    onChanged: (p0) {},
                  ),
                  FormItem(
                    name: "Cidade",
                    controller: widget.viewModel.cityController,
                    hasSecondItem: true,
                    secondName: "Estado(UF)",
                    secondController: widget.viewModel.stateController,
                    onChanged: (p0) {},
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: SFDivider(),
              ),
              FormItem(
                name: "Email",
                controller: widget.viewModel.emailController,
                onChanged: (p0) {},
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
          ),
        ),
      ],
    );
  }
}
