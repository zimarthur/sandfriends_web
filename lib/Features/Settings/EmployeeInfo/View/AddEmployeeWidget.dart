import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Settings/EmployeeInfo/ViewModel/EmployeeInfoViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/Validators.dart';

import '../../../../SharedComponents/View/SFButton.dart';
import '../../../Menu/ViewModel/MenuProvider.dart';

class AddEmployeeWidget extends StatelessWidget {
  EmployeeInfoViewModel viewModel;
  AddEmployeeWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Adicionar funcionário",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                "Se seu funcionário já criou uma conta, adicione ele à sua equipe.",
                style: TextStyle(color: textDarkGrey, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          SFTextField(
            labelText: "digite o email do funcionário",
            pourpose: TextFieldPourpose.Email,
            controller: viewModel.addEmployeeController,
            validator: emailValidator,
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
                  buttonLabel: "Adicionar",
                  buttonType: ButtonType.Primary,
                  onTap: () {
                    viewModel.addEmployee(context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
