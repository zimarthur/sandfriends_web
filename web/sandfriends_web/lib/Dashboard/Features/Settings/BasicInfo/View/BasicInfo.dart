import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/FormItem.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/ViewModel/SettingsViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';


class BasicInfo extends StatefulWidget {
  SettingsViewModel viewModel;

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
                    controller:
                        widget.viewModel.basicInfoViewModel.nameController,
                    onChanged: (p0) =>
                        widget.viewModel.storeInfoChanged(context),
                  ),
                  FormItem(
                    name: "Telefone da empresa",
                    controller:
                        widget.viewModel.basicInfoViewModel.telephoneController,
                    onChanged: (p0) =>
                        widget.viewModel.storeInfoChanged(context),
                  ),
                  FormItem(
                    name: "Telefone pessoal",
                    controller: widget
                        .viewModel.basicInfoViewModel.telephoneOwnerController,
                    onChanged: (p0) =>
                        widget.viewModel.storeInfoChanged(context),
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
                    controller:
                        widget.viewModel.basicInfoViewModel.cepController,
                    hasSecondItem: true,
                    secondName: "Bairro",
                    secondController: widget
                        .viewModel.basicInfoViewModel.neighbourhoodController,
                    onChanged: (p0) =>
                        widget.viewModel.storeInfoChanged(context),
                  ),
                  FormItem(
                    name: "Rua",
                    controller:
                        widget.viewModel.basicInfoViewModel.addressController,
                    hasSecondItem: true,
                    secondName: "N°",
                    secondController: widget
                        .viewModel.basicInfoViewModel.addressNumberController,
                    onChanged: (p0) =>
                        widget.viewModel.storeInfoChanged(context),
                  ),
                  FormItem(
                    name: "Cidade",
                    controller:
                        widget.viewModel.basicInfoViewModel.cityController,
                    hasSecondItem: true,
                    secondName: "Estado(UF)",
                    secondController:
                        widget.viewModel.basicInfoViewModel.stateController,
                    onChanged: (p0) =>
                        widget.viewModel.storeInfoChanged(context),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: SFDivider(),
              ),
              FormItem(
                name: "Email",
                controller: widget.viewModel.basicInfoViewModel.emailController,
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
          ),
        ),
      ],
    );
  }
}
