import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/Utils/TypesExtensions.dart';
import '../../../../Utils/Constants.dart';

class HourInformationWidget extends StatelessWidget {
  Animation<Offset> slideAnimation;
  CalendarViewModel viewModel;
  HourInformationWidget(
      {required this.slideAnimation, required this.viewModel, super.key});

  @override
  build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: Container(
        margin: EdgeInsets.all(defaultPadding / 2),
        padding: EdgeInsets.symmetric(
          vertical: defaultPadding / 2,
          horizontal: defaultPadding,
        ),
        height: 100,
        decoration: BoxDecoration(
          color: secondaryPaper,
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
          ),
          boxShadow: [
            BoxShadow(
              color: textLightGrey,
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: viewModel.hourInformation!.freeHour
                    ? green
                    : viewModel.hourInformation!.match
                        ? primaryBlue
                        : primaryLightBlue,
                borderRadius: BorderRadius.circular(
                  defaultBorderRadius,
                ),
              ),
            ),
            SizedBox(
              width: defaultPadding / 2,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          viewModel.hourInformation!.creatorName,
                          style: TextStyle(
                              color: viewModel.hourInformation!.freeHour
                                  ? green
                                  : viewModel.hourInformation!.match
                                      ? textBlue
                                      : primaryLightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: viewModel.hourInformation!.freeHour
                              ? green
                              : viewModel.hourInformation!.match
                                  ? textBlue
                                  : primaryLightBlue,
                        ),
                        child: SvgPicture.asset(
                          r"assets/icon/chevron_up.svg",
                          color: textWhite,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "${viewModel.hourInformation!.timeBegin.hourString} - ${viewModel.hourInformation!.timeEnd.hourString}",
                                  style: TextStyle(
                                    color: textDarkGrey,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: viewModel.hourInformation!.sport != null
                                    ? Text(
                                        viewModel.hourInformation!.sport!
                                            .description,
                                        style: TextStyle(
                                          color: textDarkGrey,
                                        ),
                                      )
                                    : Container(),
                              ),
                              Expanded(
                                child: viewModel.hourInformation!.cost != null
                                    ? Text(
                                        viewModel.hourInformation!.cost!
                                            .formatPrice(),
                                        style: TextStyle(
                                          color: textDarkGrey,
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                        if (viewModel.hourInformation!.payInStore != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2,
                                vertical: defaultPadding / 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadius,
                                ),
                                color: viewModel.hourInformation!.payInStore!
                                    ? needsPaymentBackground
                                    : paidBackground),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  viewModel.hourInformation!.payInStore!
                                      ? r"assets/icon/needs_payment.svg"
                                      : r"assets/icon/already_paid.svg",
                                  height: 20,
                                ),
                                SizedBox(
                                  width: defaultPadding / 2,
                                ),
                                Text(
                                  viewModel.hourInformation!.payInStore!
                                      ? "Pagar no local"
                                      : "Pago no app",
                                  style: TextStyle(
                                      color:
                                          viewModel.hourInformation!.payInStore!
                                              ? needsPaymentText
                                              : paidText,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
