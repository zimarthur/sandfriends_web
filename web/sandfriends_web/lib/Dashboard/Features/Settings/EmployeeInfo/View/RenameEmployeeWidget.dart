import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/Features/Settings/EmployeeInfo/ViewModel/EmployeeInfoViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Validators.dart';

import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../ViewModel/DashboardViewModel.dart';

class RenameEmployeeWidget extends StatelessWidget {
  final viewModel = EmployeeInfoViewModel();

  RenameEmployeeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return Container(
      width: 500,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Form(
        key: viewModel.renameEmployeeFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Altere seu nome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            SFTextField(
              labelText: "nome",
              pourpose: TextFieldPourpose.Standard,
              controller: viewModel.renameFirstNameController,
              validator: (value) => emptyCheck(value, "digite seu nome"),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            SFTextField(
              labelText: "sobrenome",
              pourpose: TextFieldPourpose.Standard,
              controller: viewModel.renameLastNameController,
              validator: (value) => emptyCheck(value, "digite seu sobrenome"),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Row(
              children: [
                Expanded(
                  child: SFButton(
                    buttonLabel: "Voltar",
                    buttonType: ButtonType.Secondary,
                    onTap: () {
                      viewModel.closeModal(context);
                    },
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  child: SFButton(
                    buttonLabel: "Salvar",
                    buttonType: ButtonType.Primary,
                    onTap: () {
                      if (viewModel.renameEmployeeFormKey.currentState
                              ?.validate() ==
                          true) {
                        viewModel.renameEmployee(context);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
