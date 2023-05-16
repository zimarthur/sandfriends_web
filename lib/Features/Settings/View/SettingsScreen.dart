import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Finances/ViewModel/FinancesViewModel.dart';
import 'package:sandfriends_web/Features/Settings/BrandInfo/View/BrandInfo.dart';
import 'package:sandfriends_web/Features/Settings/EmployeeInfo/View/EmployeeInfo.dart';
import 'package:sandfriends_web/Features/Settings/EmployeeInfo/ViewModel/EmployeeInfoViewModel.dart';
import 'package:sandfriends_web/Features/Settings/FinanceInfo/View/FinanceInfo.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../SharedComponents/View/SFButton.dart';
import '../../../SharedComponents/View/SFHeader.dart';
import '../../../SharedComponents/View/SFTabs.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../BasicInfo/View/BasicInfo.dart';
import '../ViewModel/SettingsViewModel.dart';

class SettingsScreen extends StatefulWidget {
  int? initForm;
  SettingsScreen({
    super.key,
    this.initForm,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final viewModel = SettingsViewModel();

  // final basicInfoViewModel = BasicInfoViewModel();
  // final brandInfoViewModel = BrandInfoViewModel();
  // final financesInfoViewModel = FinanceInfoViewModel();
  // final employeeInfoViewModel = EmployeeInfoViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initSettingsViewModel(context);
    if (widget.initForm != null) {
      setState(() {
        viewModel.currentForm = widget.initForm!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
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
                    viewModel.infoChanged
                        ? SFButton(
                            buttonLabel: "Salvar",
                            buttonType: ButtonType.Primary,
                            onTap: () {
                              //viewModel.saveStoreDifChanges(context);
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
                  tabs: viewModel.formsTitle,
                  onTap: (index) {
                    viewModel.currentForm = index;
                  },
                  selectedPosition: viewModel.currentForm,
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Expanded(
                  child: Provider.of<SettingsViewModel>(context).currentForm ==
                          0
                      ? BasicInfo(
                          viewModel: viewModel,
                        )
                      : Provider.of<SettingsViewModel>(context).currentForm == 1
                          ? BrandInfo(
                              viewModel: viewModel,
                            )
                          : Provider.of<SettingsViewModel>(context)
                                      .currentForm ==
                                  2
                              ? FinanceInfo(
                                  viewModel: viewModel,
                                )
                              : EmployeeInfo(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
