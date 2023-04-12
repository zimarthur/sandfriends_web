import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../SharedComponents/View/SFDivider.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../ViewModel/DashboardViewModel.dart';
import '../../ViewModel/CalendarViewModel.dart';
import 'package:provider/provider.dart';

import 'MatchDetailsWidgetRow.dart';

class NoMatchReservedWidget extends StatelessWidget {
  CalendarViewModel viewModel;

  NoMatchReservedWidget({required this.viewModel});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return Container(
      width: 500,
      height: height * 0.8,
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
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  r"assets/icon/sad_face.svg",
                  height: 100,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "Nenhuma partida agendada",
                  style: TextStyle(
                    color: textBlue,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: defaultPadding / 2,
                ),
                Text(
                  "Aguarde um agendamento ou bloqueie o horário",
                  style: TextStyle(
                    color: textDarkGrey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      r"assets/icon/calendar.svg",
                      height: 20,
                      color: textDarkGrey,
                    ),
                    SizedBox(
                      width: defaultPadding / 2,
                    ),
                    Text(
                      "07/04/2023",
                      style: TextStyle(
                        color: textDarkGrey,
                      ),
                    ),
                    SizedBox(
                      width: defaultPadding * 2,
                    ),
                    SvgPicture.asset(
                      r"assets/icon/clock.svg",
                      height: 20,
                      color: textDarkGrey,
                    ),
                    SizedBox(
                      width: defaultPadding / 2,
                    ),
                    Text(
                      "11:00 - 12:00",
                      style: TextStyle(
                        color: textDarkGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding / 2,
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
                  buttonLabel: "Bloquear horário",
                  buttonType: ButtonType.Delete,
                  onTap: () {
                    viewModel.setMatchCancelWidget(context, viewModel);
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
