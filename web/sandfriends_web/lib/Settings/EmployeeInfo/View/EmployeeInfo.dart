import 'package:flutter/material.dart';
import 'package:sandfriends_web/Settings/EmployeeInfo/ViewModel/EmployeeInfoViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../Menu/ViewModel/DataProvider.dart';
import '../../../SharedComponents/View/Table/SFTable.dart';
import '../../../SharedComponents/View/Table/SFTableHeader.dart';
import '../../ViewModel/SettingsViewModel.dart';

class EmployeeInfo extends StatefulWidget {
  @override
  State<EmployeeInfo> createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  final viewModel = EmployeeInfoViewModel();

  @override
  void initState() {
    viewModel.setFinancesDataSource(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Provider.of<DataProvider>(context, listen: false)
            .loggedEmployee
            .isCourtOwner)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Adicione membros à sua equipe e edite seus níveis de permissão.",
                    ),
                    Text(
                      "CUIDADO: um funcionário com acesso administrador pode ver e alterar os dados bancários da empresa e visualizar o faturamento da quadra.",
                      style: TextStyle(
                        color: textDarkGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              SFButton(
                buttonLabel: "Adic. funcionário",
                buttonType: ButtonType.Primary,
                onTap: () {
                  viewModel.goToAddEmployee(
                    context,
                    viewModel,
                  );
                },
                iconFirst: true,
                iconPath: r"assets/icon/plus.svg",
                iconSize: 14,
                textPadding: const EdgeInsets.symmetric(
                  vertical: defaultPadding / 2,
                  horizontal: defaultPadding,
                ),
              )
            ],
          ),
        const SizedBox(
          height: 2 * defaultPadding,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (layoutContext, layoutConstraints) {
              return SFTable(
                height: layoutConstraints.maxHeight,
                width: layoutConstraints.maxWidth,
                headers: [
                  SFTableHeader("name", "Nome"),
                  SFTableHeader("email", "Email"),
                  SFTableHeader("date", "Membro desde"),
                  SFTableHeader("admin", "Acesso"),
                  SFTableHeader("action", ""),
                ],
                source: viewModel.employeesDataSource!,
              );
            },
          ),
        )
      ],
    );
  }
}
