import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Settings/View/FormItem.dart';
import 'package:sandfriends_web/Features/Settings/ViewModel/SettingsViewModel.dart';
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
                    controller: widget.viewModel.nameController,
                    onChanged: (newValue) =>
                        widget.viewModel.onChangedName(newValue),
                  ),
                  FormItem(
                    name: "Telefone da empresa",
                    controller: widget.viewModel.telephoneController,
                    onChanged: (newValue) =>
                        widget.viewModel.onChangedPhoneNumber(newValue),
                  ),
                  FormItem(
                    name: "Telefone pessoal",
                    controller: widget.viewModel.telephoneOwnerController,
                    onChanged: (newValue) =>
                        widget.viewModel.onChangedPhoneNumber(newValue),
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
                    onChanged: (newValue) =>
                        widget.viewModel.onChangedCep(newValue),
                    onChangedSecond: (newValue) =>
                        widget.viewModel.onChangedNeighbourhood(newValue),
                  ),
                  FormItem(
                    name: "Rua",
                    controller: widget.viewModel.addressController,
                    hasSecondItem: true,
                    secondName: "N°",
                    secondController: widget.viewModel.addressNumberController,
                    onChanged: (newValue) =>
                        widget.viewModel.onChangedAddress(newValue),
                    onChangedSecond: (newValue) =>
                        widget.viewModel.onChangedAddressNumber(newValue),
                  ),
                  FormItem(
                    name: "Cidade",
                    controller: widget.viewModel.cityController,
                    hasSecondItem: true,
                    secondName: "Estado(UF)",
                    secondController: widget.viewModel.stateController,
                    onChanged: (newValue) =>
                        widget.viewModel.onChangedCity(newValue),
                    onChangedSecond: (newValue) =>
                        widget.viewModel.onChangedState(newValue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
