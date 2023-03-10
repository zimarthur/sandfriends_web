import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'dart:math' as math;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SFPieChart extends StatefulWidget {
  List<PieChartItem> pieChartItems;

  SFPieChart({
    required this.pieChartItems,
  });

  @override
  State<SFPieChart> createState() => _SFPieChartState();
}

class _SFPieChartState extends State<SFPieChart> {
  int touchedIndex = -1;
  ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.pieChartItems.length; i++) {
      if (i < sfColors.length) {
        widget.pieChartItems[i].color = sfColors[i];
      } else {
        widget.pieChartItems[i].color =
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);
      }
    }
    return LayoutBuilder(
      builder: (layoutContext, layoutConstaints) {
        return Row(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: layoutConstaints.maxHeight * 0.1,
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        } else {
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                          if (touchedIndex >= 0) {
                            _scrollController.scrollTo(
                                index: touchedIndex,
                                duration: Duration(milliseconds: 150));
                          }
                        }
                      });
                    },
                  ),
                  sections: <PieChartSectionData>[
                    for (int i = 0; i < widget.pieChartItems.length; i++)
                      PieChartSectionData(
                        title: widget.pieChartItems[i].value.toString(),
                        value: widget.pieChartItems[i].value,
                        color: widget.pieChartItems[i].color,
                        radius: i == touchedIndex
                            ? layoutConstaints.maxHeight * 0.4
                            : layoutConstaints.maxHeight * 0.3,
                      ),
                  ],
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SizedBox(
                width: 120,
                child: ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: widget.pieChartItems.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: index == touchedIndex
                          ? EdgeInsets.all(defaultPadding / 2)
                          : EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: index == touchedIndex
                              ? secondaryBack
                              : secondaryPaper,
                          border: index == touchedIndex
                              ? Border.all(color: primaryBlue, width: 2)
                              : Border(),
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                color: widget.pieChartItems[index].color,
                              ),
                              SizedBox(
                                width: defaultPadding,
                              ),
                              Text(
                                widget.pieChartItems[index].name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          if (index == touchedIndex)
                            Row(
                              children: [
                                SizedBox(
                                  width: defaultPadding + 10,
                                ),
                                Text(
                                  "${widget.pieChartItems[index].value.toString()} (25%)",
                                  style: TextStyle(color: textDarkGrey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class PieChartItem {
  String name;
  double value;
  Color? color;

  PieChartItem({required this.name, required this.value});
}
