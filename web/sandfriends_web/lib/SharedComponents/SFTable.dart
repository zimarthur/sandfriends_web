import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Rewards/Model/RewardDataSource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../Utils/Constants.dart';

class SFTable extends StatefulWidget {
  double height;
  double width;
  List<String> headers;
  RewardsDataSource source;

  SFTable({
    required this.height,
    required this.width,
    required this.headers,
    required this.source,
  });

  @override
  State<SFTable> createState() => _SFTableState();
}

class _SFTableState extends State<SFTable> {
  ScrollController horizontalController = ScrollController(),
      verticalController = ScrollController(),
      headerController = ScrollController();

  @override
  void initState() {
    super.initState();

    horizontalController.addListener(() {
      headerController.jumpTo(horizontalController.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    double columnWidth = widget.width / widget.headers.length < 200
        ? 200
        : widget.width / widget.headers.length;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: divider, width: 2),
        color: secondaryPaper,
      ),
      height: widget.height,
      width: widget.width,
      child: SfDataGrid(
        columns: [
          for (var header in widget.headers)
            GridColumn(
              columnName: header,
              label: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerRight,
                child: Text(
                  header,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
        source: widget.source,
      ),
    );
  }
}
