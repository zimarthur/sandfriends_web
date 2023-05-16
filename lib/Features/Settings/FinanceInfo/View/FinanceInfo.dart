import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Settings/ViewModel/SettingsViewModel.dart';

import '../../View/FormItem.dart';

class FinanceInfo extends StatefulWidget {
  SettingsViewModel viewModel;
  FinanceInfo({
    required this.viewModel,
  });
  @override
  State<FinanceInfo> createState() => _FinanceInfoState();
}

class _FinanceInfoState extends State<FinanceInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormItem(
          name: "Conta Bancária",
          controller: widget.viewModel.bankAccountController,
          onChanged: (newValue) => widget.viewModel.onChangedBankAccount(
            newValue,
          ),
        ),
        FormItem(
          name: "CNPJ",
          controller: widget.viewModel.cnpjController,
          onChanged: (newValue) => widget.viewModel.onChangedCnpj(
            newValue,
          ),
        ),
      ],
    );
  }
}
