import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'dart:math' as math;

class SFPieChart extends StatefulWidget {
  List<PieChartItem> pieChartItems;

  SFPieChart({
    required this.pieChartItems,
  });

  @override
  State<SFPieChart> createState() => _SFPieChartState();
}

class _SFPieChartState extends State<SFPieChart> {
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
    return Row(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(sections: <PieChartSectionData>[
              for (var item in widget.pieChartItems)
                PieChartSectionData(
                  title: item.value.toString(),
                  value: item.value,
                  color: item.color,
                ),
            ]),
            swapAnimationDuration: Duration(milliseconds: 150), // Optional
            swapAnimationCurve: Curves.linear, // Optional
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            width: 100,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (var item in widget.pieChartItems)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          color: item.color,
                        ),
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PieChartItem {
  String name;
  double value;
  Color? color;

  PieChartItem({required this.name, required this.value});
}
