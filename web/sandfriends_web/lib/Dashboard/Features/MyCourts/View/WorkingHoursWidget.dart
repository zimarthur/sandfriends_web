import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Dashboard/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';

import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../Utils/Constants.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'HourSelector.dart';

class WorkingHoursWidget extends StatefulWidget {
  MyCourtsViewModel viewModel;

  WorkingHoursWidget({super.key, 
    required this.viewModel,
  });

  @override
  State<WorkingHoursWidget> createState() => _WorkingHoursWidgetState();
}

class _WorkingHoursWidgetState extends State<WorkingHoursWidget> {
  List<OperationDay> newOperationDays = [];

  @override
  void initState() {
    if (Provider.of<DataProvider>(context, listen: false)
        .operationDays
        .isEmpty) {
      for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
        newOperationDays.add(
          OperationDay(
            weekDay: dayIndex,
            startingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .first,
            endingHour: Provider.of<DataProvider>(context, listen: false)
                .availableHours
                .last,
            isEnabled: true,
          ),
        );
      }
    } else {
      newOperationDays = Provider.of<DataProvider>(context, listen: false)
          .operationDays
          .map(
            (opDay) => OperationDay(
              weekDay: opDay.weekDay,
              startingHour: opDay.startingHour,
              endingHour: opDay.endingHour,
              isEnabled: opDay.isEnabled,
            ),
          )
          .toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return Container(
      height: height * 0.8,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Horário de funcionamento.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                "Configure o horário de funcionamento do seu estabelecimento",
                style: TextStyle(color: textDarkGrey, fontSize: 14),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < newOperationDays.length; i++)
                          Expanded(
                            child: HourSelector(
                              operationDay: newOperationDays[i],
                              availableHours: Provider.of<DataProvider>(context,
                                      listen: false)
                                  .availableHours,
                            ),
                          )
                      ],
                    ),
                  ),
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
                    widget.viewModel.returnMainView(context);
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
                    widget.viewModel
                        .saveNewOperationDays(context, newOperationDays);
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
