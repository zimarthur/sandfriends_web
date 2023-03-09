import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDropDown.dart';

import '../../../../SharedComponents/Model/Hour.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../Utils/Constants.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'HourSelector.dart';

class WorkingHoursWidget extends StatefulWidget {
  const WorkingHoursWidget({super.key});

  @override
  State<WorkingHoursWidget> createState() => _WorkingHoursWidgetState();
}

class _WorkingHoursWidgetState extends State<WorkingHoursWidget> {
  final MyCourtsViewModel viewModel = MyCourtsViewModel();

  List<String> weeKDays = [
    "segunda-feira",
    "terça-feira",
    "quarta-feira",
    "quinta-feira",
    "sexta-feira",
    "sábado",
    "domingo"
  ];

  Hour startHour = Hour(hour: 8, hourString: "08:00");
  Hour endHour = Hour(hour: 21, hourString: "21:00");
  List<Hour> availableHours = [
    Hour(hourString: "08:00", hour: 8),
    Hour(hourString: "09:00", hour: 9),
    Hour(hourString: "10:00", hour: 10),
    Hour(hourString: "11:00", hour: 11),
    Hour(hourString: "12:00", hour: 12),
    Hour(hourString: "13:00", hour: 13),
    Hour(hourString: "14:00", hour: 14),
    Hour(hourString: "15:00", hour: 15),
    Hour(hourString: "16:00", hour: 16),
    Hour(hourString: "17:00", hour: 17),
    Hour(hourString: "18:00", hour: 18),
    Hour(hourString: "19:00", hour: 19),
    Hour(hourString: "20:00", hour: 20),
    Hour(hourString: "21:00", hour: 21),
  ];
  String hourvalue = "08:00";
  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return ChangeNotifierProvider<MyCourtsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<MyCourtsViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            height: height * 0.8,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Horário de funcionamento.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      "Configure o horário de funcionamento do seu estabelecimento",
                      style: TextStyle(color: textDarkGrey, fontSize: 14),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (int i = 0; i < weeKDays.length; i++)
                                Expanded(
                                  child: HourSelector(
                                    availableHours: availableHours,
                                    title: weeKDays[i],
                                    startHour: startHour,
                                    endHour: endHour,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SFButton(
                    buttonLabel: "Voltar",
                    buttonType: ButtonType.Secondary,
                    onTap: () {
                      viewModel.returnMainView(context);
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
