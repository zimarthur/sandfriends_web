import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/Model/AppMatch.dart';
import '../../../../SharedComponents/View/SFPaymentStatus.dart';

class ResumedMatch extends StatelessWidget {
  AppMatch match;
  ResumedMatch({
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, layoutConstraints) {
      return Container(
        width: layoutConstraints.maxWidth,
        height: 100,
        margin: const EdgeInsets.only(right: defaultPadding, bottom: 3),
        decoration: BoxDecoration(
          color: primaryBlue,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          boxShadow: const [
            BoxShadow(
              color: divider,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2,
                vertical: defaultPadding / 4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      Provider.of<DataProvider>(context, listen: false)
                          .courts
                          .firstWhere((court) =>
                              court.idStoreCourt == match.court.idStoreCourt)
                          .description,
                      style: TextStyle(
                        color: textWhite,
                      ),
                    ),
                  ),
                  SFPaymentStatus(selectedPayment: match.selectedPayment)
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2,
                  vertical: defaultPadding / 2,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondaryPaper,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
                child: match.blocked
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Horário Bloqueado",
                            style: TextStyle(
                              color: textBlue,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            match.blockedReason,
                            style: TextStyle(
                              color: textDarkGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Partida de ${match.matchCreatorFirstName}",
                            style: TextStyle(
                              color: textBlue,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            match.sport?.description ?? "",
                            style: TextStyle(
                              color: textDarkGrey,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${match.startingHour.hourString} - ${match.endingHour.hourString}",
                            style: TextStyle(
                              color: textDarkGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ),
            )
          ],
        ),
      );
    });
  }
}
