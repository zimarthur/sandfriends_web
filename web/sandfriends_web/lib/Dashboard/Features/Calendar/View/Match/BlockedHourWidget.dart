import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../SharedComponents/View/SFDivider.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../ViewModel/DashboardViewModel.dart';
import '../../ViewModel/CalendarViewModel.dart';
import 'package:provider/provider.dart';

import 'MatchDetailsWidgetRow.dart';

class BlockedHourWidget extends StatelessWidget {
  CalendarViewModel viewModel;

  BlockedHourWidget({required this.viewModel});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = "blablabla";
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return Container(
      width: 500,
      padding: EdgeInsets.all(defaultPadding),
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Horário bloqueado",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: red,
                  ),
                ),
                SizedBox(
                  height: 2 * defaultPadding,
                ),
                MatchDetailsWidgetRow(title: "Dia", value: "07/04/2023"),
                MatchDetailsWidgetRow(title: "Horário", value: "16:00 - 17:00"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: SFDivider(),
                ),
                Text(
                  "Motivo do Bloqueio",
                  style: TextStyle(
                    color: textDarkGrey,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: SFTextField(
                    labelText: "",
                    pourpose: TextFieldPourpose.Multiline,
                    minLines: 4,
                    maxLines: 4,
                    enable: false,
                    controller: controller,
                    validator: (a) {},
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SFButton(
                  buttonLabel: "Voltar",
                  buttonType: ButtonType.Secondary,
                  onTap: () {
                    viewModel.returnMainView(context);
                  },
                ),
              ),
              SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: SFButton(
                  buttonLabel: "Desbloquear horário",
                  buttonType: ButtonType.Primary,
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
