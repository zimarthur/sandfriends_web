import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Model/CalendarWeeklyDayMatch.dart';
import 'package:sandfriends_web/Features/Calendar/View/Modal/Match/MatchDetailsWidgetRow.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppMatch.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppRecurrentMatch.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../../SharedComponents/Model/Court.dart';
import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../Menu/ViewModel/MenuProvider.dart';

class CourtsAvailabilityWidget extends StatelessWidget {
  CalendarViewModel viewModel;
  Hour hour;
  DateTime day;
  List<AppMatch> matches;
  List<AppRecurrentMatch> recurrentMatches;

  CourtsAvailabilityWidget({
    super.key,
    required this.viewModel,
    required this.hour,
    required this.day,
    required this.matches,
    required this.recurrentMatches,
  });

  @override
  Widget build(BuildContext context) {
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
    return Container(
      height: height * 0.9,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Partidas do dia",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: textBlue),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                MatchDetailsWidgetRow(
                  title: "Dia",
                  value: DateFormat("dd/MM/yyyy").format(day),
                ),
                MatchDetailsWidgetRow(
                  title: "Horário",
                  value:
                      "${hour.hourString} - ${Provider.of<DataProvider>(context, listen: false).availableHours.firstWhere((hr) => hr.hour > hour.hour).hourString}",
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: defaultPadding),
                  child: SFDivider(),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: Provider.of<DataProvider>(context, listen: false)
                      .courts
                      .length,
                  itemBuilder: (context, index) {
                    AppMatch? match;
                    AppRecurrentMatch? recurrentMatch;
                    Court court =
                        Provider.of<DataProvider>(context, listen: false)
                            .courts[index];
                    if (matches.any(
                        (match) => match.idStoreCourt == court.idStoreCourt)) {
                      match = matches.firstWhere((match) =>
                          match.idStoreCourt ==
                          Provider.of<DataProvider>(context, listen: false)
                              .courts[index]
                              .idStoreCourt);
                    } else if (recurrentMatches.any((recMatch) =>
                        recMatch.idStoreCourt == court.idStoreCourt)) {
                      recurrentMatch = recurrentMatches.firstWhere((recMatch) =>
                          recMatch.idStoreCourt ==
                          Provider.of<DataProvider>(context, listen: false)
                              .courts[index]
                              .idStoreCourt);
                    }

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index ==
                                Provider.of<DataProvider>(context,
                                            listen: false)
                                        .courts
                                        .length -
                                    1
                            ? 0
                            : defaultPadding,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            court.description,
                          )),
                          Container(
                            width: 80,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPadding / 4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius),
                                color: match != null || recurrentMatch != null
                                    ? secondaryYellow
                                    : secondaryGreen),
                            child: Text(
                              match != null || recurrentMatch != null
                                  ? "Ocupado"
                                  : "Livre",
                              style: TextStyle(
                                color: textWhite,
                              ),
                            ),
                          ),
                          Expanded(
                            child: match != null
                                ? Text(
                                    match.matchCreatorName,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  )
                                : recurrentMatch != null
                                    ? Text(
                                        recurrentMatch.blockedReason,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      )
                                    : Container(),
                          ),
                          Expanded(
                            child: match != null
                                ? Text(
                                    match.sport!.description,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  )
                                : recurrentMatch != null
                                    ? Text(
                                        recurrentMatch.sport!.description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300),
                                      )
                                    : Container(),
                          ),
                          Expanded(
                            child: match != null || recurrentMatch != null
                                ? Text(
                                    "Pago",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300),
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    );
                  },
                )),
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
            ],
          )
        ],
      ),
    );
  }
}
