import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

import '../../../SharedComponents/Model/AppMatch.dart';

class FinancesDataSource extends DataGridSource {
  FinancesDataSource({required List<AppMatch> matches}) {
    _finances = matches
        .map<DataGridRow>(
          (match) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'date',
                  value: DateFormat('dd/MM/yy').format(match.date)),
              DataGridCell<String>(
                  columnName: 'hour',
                  value:
                      "${match.startingHour.hourString} - ${match.endingHour.hourString}"),
              DataGridCell<String>(
                  columnName: 'court',
                  value: "Quadra ${match.idStoreCourt.toString()}"),
              DataGridCell<String>(
                  columnName: 'price', value: "R\$${match.cost}"),
              const DataGridCell<String>(columnName: 'player', value: "Arthur"),
              DataGridCell<String>(
                columnName: 'sport',
                value: match.sport.description,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _finances = [];

  @override
  List<DataGridRow> get rows => _finances;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: defaultPadding),
              child: Flexible(
                child: Text(
                  dataGridCell.value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: divider,
            ),
          ],
        );
      }).toList(),
    );
  }
}
