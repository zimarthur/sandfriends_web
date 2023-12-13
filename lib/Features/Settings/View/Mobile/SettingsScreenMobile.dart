import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Features/Settings/ViewModel/SettingsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../Menu/ViewModel/MenuProvider.dart';

class SettingsScreenMobile extends StatefulWidget {
  String? initForm;
  SettingsScreenMobile({
    super.key,
    this.initForm,
  });

  @override
  State<SettingsScreenMobile> createState() => _SettingsScreenMobileState();
}

class _SettingsScreenMobileState extends State<SettingsScreenMobile> {
  final SettingsViewModel viewModel = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<SettingsViewModel>(builder: (context, viewModel, _) {
        return Container(
          color: secondaryBack,
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ativar notificações",
                    style: TextStyle(
                      color: textBlue,
                    ),
                  ),
                  Switch(
                    value: Provider.of<DataProvider>(context)
                        .loggedEmployee
                        .allowNotifications,
                    onChanged: (value) =>
                        viewModel.updateAllowNotifications(context, value),
                  )
                ],
              ),
              Column(
                children: [
                  SFButton(
                    buttonLabel: "Sair",
                    buttonType: ButtonType.Delete,
                    onTap: () =>
                        Provider.of<MenuProvider>(context, listen: false)
                            .logout(context),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  InkWell(
                    onTap: () => viewModel.deleteAccount(context),
                    child: Text(
                      "Deletar conta",
                      style: TextStyle(
                        color: red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2 * defaultPadding,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
