import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/MyCourts/View/CourtDay/PriceRuleRadio.dart';
import 'package:sandfriends_web/Features/MyCourts/View/CourtDay/ResumedInfoRow.dart';
import 'package:sandfriends_web/Features/MyCourts/View/CourtDay/PriceSelector.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../SharedComponents/Model/Court.dart';
import '../../../../SharedComponents/Model/HourPrice.dart';
import '../../../../SharedComponents/Model/OperationDay.dart';
import '../../ViewModel/MyCourtsViewModel.dart';
import 'PriceSelectorHeader.dart';

class CourtDay extends StatefulWidget {
  double width;
  double height;
  OperationDay operationDay;
  MyCourtsViewModel viewModel;

  CourtDay({
    super.key,
    required this.width,
    required this.height,
    required this.operationDay,
    required this.viewModel,
  });

  @override
  State<CourtDay> createState() => _CourtDayState();
}

class _CourtDayState extends State<CourtDay> {
  bool isExpanded = false;
  double borderSize = 2;
  double editIconWidth = 50;

  TextEditingController controller = TextEditingController();
  double arrowHeight = 25;

  List<HourPrice> priceRules = [];

  bool forceIsPriceCustom = false;

  @override
  Widget build(BuildContext context) {
    double mainRowHeight = widget.height - 2 * borderSize;
    double secondaryRowHeight = mainRowHeight * 0.7;
    int numberRules = widget.operationDay.priceRules.length;
    double standardHeight =
        mainRowHeight * 2 + secondaryRowHeight + mainRowHeight;
    double customHeight =
        mainRowHeight * 2 + secondaryRowHeight + numberRules * mainRowHeight;
    bool isPriceStandard =
        widget.operationDay.priceRules.length == 1 || forceIsPriceCustom;
    double expandedHeight = isPriceStandard
        ? standardHeight - mainRowHeight - 2
        : customHeight - mainRowHeight - 2;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isExpanded
          ? isPriceStandard
              ? standardHeight + borderSize + arrowHeight
              : customHeight + borderSize + arrowHeight
          : widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: primaryBlue),
      padding: EdgeInsets.all(borderSize),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isExpanded
                        ? isPriceStandard
                            ? standardHeight
                            : customHeight
                        : mainRowHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      color: secondaryPaper,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                right: isExpanded ? editIconWidth : 0),
                            height: mainRowHeight,
                            child: ResumedInfoRow(
                                operationDay: widget.operationDay,
                                isEditing: isExpanded,
                                rowHeight: mainRowHeight,
                                setAllowRecurrent: (newValue) {
                                  Provider.of<MyCourtsViewModel>(context,
                                          listen: false)
                                      .setAllowRecurrent(
                                    widget.operationDay,
                                    newValue,
                                  );
                                }),
                          ),
                          AnimatedSize(
                              duration: const Duration(milliseconds: 200),
                              child: isExpanded
                                  ? Container(
                                      height: expandedHeight,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding),
                                      child: Column(
                                        children: [
                                          const SFDivider(),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: mainRowHeight,
                                            child: const Text(
                                              "Regra de preço",
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    PriceSelectorRadio(
                                                        height:
                                                            secondaryRowHeight,
                                                        isPriceStandard:
                                                            isPriceStandard,
                                                        onChange: (value) {
                                                          setState(() {
                                                            if (value != null) {
                                                              forceIsPriceCustom =
                                                                  value;
                                                            }
                                                          });
                                                          Provider.of<MyCourtsViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .setIsPriceStandard(
                                                            widget.operationDay,
                                                            value!,
                                                          );
                                                        }),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            secondaryRowHeight,
                                                        child:
                                                            PriceSelectorHeader(
                                                          allowRecurrent: widget
                                                              .operationDay
                                                              .allowReccurrent,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: ListView.builder(
                                                          itemCount: widget
                                                              .operationDay
                                                              .priceRules
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return PriceSelector(
                                                              allowRecurrent: widget
                                                                  .operationDay
                                                                  .allowReccurrent,
                                                              priceRule: widget
                                                                  .operationDay
                                                                  .priceRules[index],
                                                              height:
                                                                  mainRowHeight,
                                                              availableHours: Provider.of<
                                                                          DataProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .availableHours
                                                                  .where(
                                                                      (hour) {
                                                                var validDay = widget
                                                                    .viewModel
                                                                    .storeWorkingDays
                                                                    .firstWhere((workingDay) =>
                                                                        workingDay
                                                                            .weekday ==
                                                                        widget
                                                                            .operationDay
                                                                            .weekday);
                                                                return hour.hour >=
                                                                        validDay
                                                                            .startingHour!
                                                                            .hour &&
                                                                    hour.hour <=
                                                                        validDay
                                                                            .endingHour!
                                                                            .hour;
                                                              }).toList(),
                                                              editHour:
                                                                  !isPriceStandard,
                                                              onChangedStartingHour: (oldHour,
                                                                      newHour) =>
                                                                  widget
                                                                      .viewModel
                                                                      .onChangedRuleStartingHour(
                                                                context,
                                                                widget
                                                                    .operationDay,
                                                                oldHour,
                                                                newHour,
                                                              ),
                                                              onChangedEndingHour: (oldHour,
                                                                      newHour) =>
                                                                  widget
                                                                      .viewModel
                                                                      .onChangedRuleEndingHour(
                                                                context,
                                                                widget
                                                                    .operationDay,
                                                                oldHour,
                                                                newHour,
                                                              ),
                                                              onChangedPrice: (newPrice,
                                                                      priceRule) =>
                                                                  widget.viewModel.onChangedPrice(
                                                                      newPrice,
                                                                      priceRule,
                                                                      widget
                                                                          .operationDay,
                                                                      false),
                                                              onChangedRecurrentPrice: (newPrice,
                                                                      priceRule) =>
                                                                  widget
                                                                      .viewModel
                                                                      .onChangedPrice(
                                                                          newPrice,
                                                                          priceRule,
                                                                          widget
                                                                              .operationDay,
                                                                          true),
                                                            );
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox()),
                        ],
                      ),
                    ),
                  ),
                ),
                isExpanded
                    ? Container()
                    : InkWell(
                        onTap: () {
                          if (widget.operationDay.isEnabled) {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          }
                        },
                        child: SizedBox(
                          width: editIconWidth,
                          child: SvgPicture.asset(
                            r'assets/icon/edit.svg',
                            color: Colors.white,
                            height: 16,
                          ),
                        ),
                      )
              ],
            ),
          ),
          isExpanded
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: SvgPicture.asset(
                      r'assets/icon/chevron_up.svg',
                      color: Colors.white,
                      height: arrowHeight,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
