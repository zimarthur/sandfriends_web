import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'dart:math' as math;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SFPieChart extends StatefulWidget {
  List<PieChartItem> pieChartItems;

  SFPieChart({
    super.key,
    required this.pieChartItems,
  });

  @override
  State<SFPieChart> createState() => _SFPieChartState();
}

class _SFPieChartState extends State<SFPieChart> {
  int touchedIndex = -1;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    double chartValuesSum =
        widget.pieChartItems.fold(0, (sum, item) => sum + item.value);
    for (int i = 0; i < widget.pieChartItems.length; i++) {
      if (i < sfColors.length) {
        widget.pieChartItems[i].color = sfColors[i];
      } else {
        widget.pieChartItems[i].color =
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);
      }
    }
    return widget.pieChartItems.isEmpty
        ? Container()
        : LayoutBuilder(
            builder: (layoutContext, layoutConstaints) {
              return Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: layoutConstaints.maxHeight * 0.1,
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
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
                                      duration:
                                          const Duration(milliseconds: 150));
                                }
                              }
                            });
                          },
                        ),
                        sections: <PieChartSectionData>[
                          for (int i = 0; i < widget.pieChartItems.length; i++)
                            PieChartSectionData(
                              title:
                                  "${(widget.pieChartItems[i].value * 100 / chartValuesSum).toStringAsFixed(0)}%",
                              value: widget.pieChartItems[i].value,
                              color: widget.pieChartItems[i].color,
                              radius: i == touchedIndex
                                  ? layoutConstaints.maxHeight * 0.4
                                  : layoutConstaints.maxHeight * 0.3,
                            ),
                        ],
                      ),
                      swapAnimationDuration:
                          const Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: SizedBox(
                      width: 200,
                      child: ScrollablePositionedList.builder(
                        itemScrollController: _scrollController,
                        itemCount: widget.pieChartItems.length,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: index == touchedIndex
                                ? const EdgeInsets.all(defaultPadding / 2)
                                : const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: index == touchedIndex
                                    ? secondaryBack
                                    : secondaryPaper,
                                border: index == touchedIndex
                                    ? Border.all(color: primaryBlue, width: 2)
                                    : const Border(),
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
                                    const SizedBox(
                                      width: defaultPadding,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.pieChartItems[index].name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                if (index == touchedIndex)
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: defaultPadding + 10,
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          "${widget.pieChartItems[index].prefix == null ? "" : "${widget.pieChartItems[index].prefix} "}${widget.pieChartItems[index].value.toString()} (${(widget.pieChartItems[index].value * 100 / chartValuesSum).toStringAsFixed(0)}%)",
                                          minFontSize: 8,
                                          maxFontSize: 18,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: textDarkGrey,
                                          ),
                                        ),
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
  String? prefix;

  PieChartItem({required this.name, required this.value, this.prefix});
}
