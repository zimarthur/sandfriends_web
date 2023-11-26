import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/Model/DayMatch.dart';
import 'package:sandfriends_web/Features/Calendar/Model/HourInformation.dart';
import 'package:sandfriends_web/Features/Calendar/View/Mobile/HourInformationWidget.dart';
import 'package:sandfriends_web/Utils/TypesExtensions.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/Model/Hour.dart';
import '../../../../Utils/Constants.dart';
import '../../ViewModel/CalendarViewModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarWidgetMobile extends StatefulWidget {
  CalendarViewModel viewModel;
  CalendarWidgetMobile({required this.viewModel, super.key});

  @override
  State<CalendarWidgetMobile> createState() => _CalendarWidgetMobileState();
}

class _CalendarWidgetMobileState extends State<CalendarWidgetMobile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<Offset> _slideAnimation =
      Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
          .animate(_slideAnimationController);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.horizontalController.addListener(() {
        disposeHourInfo();
      });
      widget.viewModel.verticalController.addListener(() {
        disposeHourInfo();
      });
    });

    super.initState();
  }

  void disposeHourInfo() {
    if (widget.viewModel.showHourInfoMobile) {
      _slideAnimationController.reverse().whenComplete(() {
        widget.viewModel.setShowHourInfo();
      });
    }
  }

  @override
  void dispose() {
    widget.viewModel.verticalController.removeListener(() {});
    widget.viewModel.horizontalController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        disposeHourInfo();
      },
      child: Column(
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: TableView.builder(
                  rowCount: widget.viewModel.selectedDayWorkingHours.length + 1,
                  columnCount: widget.viewModel.courts.length + 1,
                  columnBuilder: _buildColumnSpan,
                  rowBuilder: _buildRowSpan,
                  cellBuilder: _buildCell,
                  pinnedRowCount: 1,
                  pinnedColumnCount: 1,
                  verticalDetails: ScrollableDetails.vertical(
                    controller: widget.viewModel.verticalController,
                  ),
                  horizontalDetails: ScrollableDetails.horizontal(
                      controller: widget.viewModel.horizontalController),
                )),
          ),
          if (widget.viewModel.showHourInfoMobile)
            HourInformationWidget(
              slideAnimation: _slideAnimation,
              viewModel: widget.viewModel,
            ),
        ],
      ),
    );
  }

  Widget _buildCell(BuildContext context, TableVicinity vicinity) {
    int realRowIndex = vicinity.row - 1;
    int realColumnIndex = vicinity.column - 1;

    if (vicinity.column == 0) {
      if (vicinity.row == 0) {
        return Container();
      } else {
        return Text(
          widget.viewModel.selectedDayWorkingHours[realRowIndex].hourString,
          style: TextStyle(
            color: textDarkGrey,
          ),
        );
      }
    } else if (vicinity.row == 0) {
      return Center(
        child: Text(
          widget.viewModel.courts[realColumnIndex].description,
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    Hour displayHour = widget.viewModel.selectedDayWorkingHours[realRowIndex];
    DayMatch displayDayMatch = widget
        .viewModel.selectedDayMatches[realColumnIndex].dayMatches
        .lastWhere(
            (dayMatch) => dayMatch.startingHour.hour <= displayHour.hour);
    bool hasEvent =
        displayDayMatch.match != null || displayDayMatch.recurrentMatch != null;
    if (hasEvent) {
      return InkWell(
        onTap: () {
          _slideAnimationController.forward();
          widget.viewModel.onTapHour(
            HourInformation(
              match: displayDayMatch.match != null,
              recurrentMatch: displayDayMatch.recurrentMatch != null,
              creatorName: displayDayMatch.match != null
                  ? "Partida de ${displayDayMatch.match!.matchCreatorName}"
                  : "Mensalista de ${displayDayMatch.recurrentMatch!.creatorName}",
              timeBegin: displayDayMatch.match != null
                  ? displayDayMatch.match!.startingHour
                  : displayDayMatch.recurrentMatch!.startingHour,
              timeEnd: displayDayMatch.match != null
                  ? displayDayMatch.match!.endingHour
                  : displayDayMatch.recurrentMatch!.endingHour,
              sport: displayDayMatch.match != null
                  ? displayDayMatch.match!.sport
                  : displayDayMatch.recurrentMatch!.sport,
              cost: displayDayMatch.match != null
                  ? displayDayMatch.match!.cost
                  : displayDayMatch.recurrentMatch!.matchCost,
              payInStore: displayDayMatch.match != null
                  ? displayDayMatch.match!.payInStore
                  : displayDayMatch.recurrentMatch!.payInStore,
              selectedColumn: vicinity.column,
              selectedRow: vicinity.row,
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.all(
            defaultPadding / 4,
          ),
          padding: EdgeInsets.all(
            defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              defaultBorderRadius,
            ),
            color: displayDayMatch.match != null
                ? primaryBlue.withAlpha(64)
                : primaryLightBlue.withAlpha(64),
          ),
          child: Row(
            children: [
              Container(
                width: 5,
                decoration: BoxDecoration(
                  color: displayDayMatch.match != null
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayDayMatch.match != null
                          ? displayDayMatch.match!.matchCreatorName
                          : displayDayMatch.recurrentMatch!.creatorName,
                      style: TextStyle(
                        color: displayDayMatch.match != null
                            ? primaryBlue
                            : primaryLightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      displayDayMatch.match != null
                          ? displayDayMatch.match!.sport!.description
                          : displayDayMatch.recurrentMatch!.sport!.description,
                      style: TextStyle(
                        color: textDarkGrey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          _slideAnimationController.forward();
          widget.viewModel.onTapHour(
            HourInformation(
                creatorName: "Horário disponível",
                timeBegin:
                    widget.viewModel.selectedDayWorkingHours[realRowIndex],
                timeEnd: widget.viewModel.availableHours.firstWhere((hour) =>
                    hour.hour >
                    widget
                        .viewModel.selectedDayWorkingHours[realRowIndex].hour),
                selectedColumn: vicinity.column,
                selectedRow: vicinity.row,
                freeHour: true),
          );
        },
        child: widget.viewModel.hourInformation != null
            ? widget.viewModel.hourInformation!.selectedColumn ==
                        vicinity.column &&
                    widget.viewModel.hourInformation!.selectedRow ==
                        vicinity.row
                ? Container(
                    margin: EdgeInsets.all(
                      defaultPadding / 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        defaultBorderRadius,
                      ),
                      border: Border.all(color: paidText, width: 2),
                      color: paidBackground,
                    ),
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                          color: paidText,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  )
                : Container()
            : Container(),
      );
    }
  }

  TableSpan _buildColumnSpan(int index) {
    const TableSpanDecoration decoration = TableSpanDecoration(
      border: TableSpanBorder(),
    );

    switch (index) {
      case 0:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(80),
        );
      default:
        return TableSpan(
          foregroundDecoration: decoration,
          extent: const FixedTableSpanExtent(150),
          onEnter: (_) => print('Entered column $index'),
        );
    }
  }

  TableSpan _buildRowSpan(int index) {
    final TableSpanDecoration decoration = TableSpanDecoration(
      color: secondaryBack,
      border: const TableSpanBorder(
        trailing: BorderSide(
          width: 2,
          color: textLightGrey,
        ),
      ),
    );

    return TableSpan(
      backgroundDecoration: decoration,
      extent: const FixedTableSpanExtent(60),
      padding: TableSpanPadding.all(defaultPadding / 2),
    );
  }
}