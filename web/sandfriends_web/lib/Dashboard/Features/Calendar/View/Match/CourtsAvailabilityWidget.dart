import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/Model/PaymentType.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/View/Match/MatchDetailsWidgetRow.dart';
import 'package:sandfriends_web/Dashboard/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/SharedComponents/View/Table/SFTable.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../ViewModel/DashboardViewModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourtsAvailabilityWidget extends StatelessWidget {
  CalendarViewModel viewModel;

  CourtsAvailabilityWidget({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return Container(
      height: height * 0.9,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Suas quadras para",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: textBlue),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  MatchDetailsWidgetRow(
                    title: "Dia",
                    value: "01/01/2023",
                  ),

                  MatchDetailsWidgetRow(
                    title: "Horário",
                    value: "21:00 - 22:00",
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SFDivider(),
                  ),
                  // Expanded(child: LayoutBuilder(
                  //   builder: (layoutContext, layoutConstraints) {
                  //     return SFTable(height: layoutConstraints.maxHeight, width: layoutConstraints.maxWidth, headers: headers, source: source);
                  //   },
                  // ),),
                ],
              ),
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
                  buttonLabel: "Cancelar partida",
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
