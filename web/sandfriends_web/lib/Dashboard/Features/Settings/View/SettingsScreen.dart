import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/BrandInfo.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/View/FinanceInfo.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFTabs.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'BasicInfo.dart';
import 'SettingsViewModel.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsViewModel viewModel = SettingsViewModel();

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
          print("build ${viewModel.currentForm}");
          return Container(
            color: secondaryBack,
            child: Column(
              children: [
                SFHeader(
                  header: "Configurações",
                  description:
                      "Gerencie as informações e a identidade visual do seu negócio, bem como seus dados financeiros",
                ),
                SFTabs(
                  tabs: ["Dados básicos", "Sua marca", "Dados financeiros"],
                  onTap: (index) {
                    print(index);
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
                            ? BasicInfo(viewModel)
                            : Provider.of<SettingsViewModel>(context)
                                        .currentForm ==
                                    1
                                ? BrandInfo(viewModel)
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
