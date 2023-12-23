import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/View/SFPieChart.dart';

import 'SFCard.dart';

class SFPieChartWeb extends StatefulWidget {
  double height;
  double width;
  String title;
  List<PieChartItem> pieChartItems;
  SFPieChartWeb(
      {required this.height,
      required this.width,
      required this.title,
      required this.pieChartItems,
      super.key});

  @override
  State<SFPieChartWeb> createState() => _SFPieChartWebState();
}

class _SFPieChartWebState extends State<SFPieChartWeb> {
  @override
  Widget build(BuildContext context) {
    return SFCard(
      height: widget.height,
      width: widget.width,
      title: widget.title,
      child: SFPieChart(
        pieChartItems: widget.pieChartItems,
        showLabels: true,
      ),
    );
  }
}
