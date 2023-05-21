import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/OperationDay.dart';
import 'package:sandfriends_web/SharedComponents/Model/StoreWorkingHours.dart';

import '../../../SharedComponents/View/SFButton.dart';
import '../../../Utils/Constants.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import 'HourSelector.dart';

class WorkingHoursModal extends StatefulWidget {
  MyCourtsViewModel viewModel;

  WorkingHoursModal({
    super.key,
    required this.viewModel,
  });

  @override
  State<WorkingHoursModal> createState() => _WorkingHoursWidgetState();
}

class _WorkingHoursWidgetState extends State<WorkingHoursModal> {
  List<StoreWorkingDay> storeWorkingDays = [];

  @override
  void initState() {
    if (widget.viewModel.storeWorkingDays.isEmpty) {
      for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
        storeWorkingDays.add(
          StoreWorkingDay(
            weekday: dayIndex,
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
      for (var storeWorkingHours in widget.viewModel.storeWorkingDays) {
        storeWorkingDays.add(
          StoreWorkingDay.copyFrom(
            storeWorkingHours,
          ),
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
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
                        for (var storeWorkingDay in storeWorkingDays)
                          Expanded(
                            child: HourSelector(
                              storeWorkingDay: storeWorkingDay,
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
                    widget.viewModel.closeModal(context);
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
                        .saveNewStoreWorkingSDays(context, storeWorkingDays);
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
