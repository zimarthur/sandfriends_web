import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/BrandInfo.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/FinanceInfo.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFTabs.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'BasicInfo.dart';
import '../ViewModel/SettingsViewModel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsViewModel viewModel = SettingsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.setFields(context);
  }

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<SettingsViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: SFHeader(
                        header: "Meu perfil",
                        description:
                            "Gerencie as informações e a identidade visual do seu negócio, bem como seus dados financeiros",
                      ),
                    ),
                    viewModel.storeInfoDif
                        ? SFButton(
                            buttonLabel: "Salvar",
                            buttonType: ButtonType.Primary,
                            onTap: () {
                              viewModel.saveStoreDifChanges(context);
                            },
                            textPadding: const EdgeInsets.symmetric(
                              vertical: defaultPadding,
                              horizontal: defaultPadding * 2,
                            ),
                          )
                        : Container()
                  ],
                ),
                SFTabs(
                  tabs: ["Dados básicos", "Sua marca", "Dados financeiros"],
                  onTap: (index) {
                    viewModel.currentForm = index;
                  },
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Provider.of<SettingsViewModel>(context)
                                    .currentForm ==
                                0
                            ? BasicInfo(
                                viewModel: viewModel,
                              )
                            : Provider.of<SettingsViewModel>(context)
                                        .currentForm ==
                                    1
                                ? BrandInfo(
                                    viewModel: viewModel,
                                  )
                                : FinanceInfo(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
