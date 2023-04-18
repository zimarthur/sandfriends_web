import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../ViewModel/SettingsViewModel.dart';

class EmployeeInfo extends StatelessWidget {
  SettingsViewModel viewModel;

  EmployeeInfo({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            SizedBox(
              width: defaultPadding,
            ),
            SFButton(
              buttonLabel: "Adic. funcionário",
              buttonType: ButtonType.Primary,
              onTap: () {},
              iconFirst: true,
              iconPath: r"assets/icon/plus.svg",
              textPadding: EdgeInsets.symmetric(
                vertical: defaultPadding / 4,
                horizontal: defaultPadding / 2,
              ),
            )
          ],
        ),
      ],
    );
  }
}
