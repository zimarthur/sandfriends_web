import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/Employee.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../SharedComponents/Model/Match.dart';
import 'package:intl/intl.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employees = employees
        .map<DataGridRow>(
          (employee) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'name',
                value: "${employee.firstName} ${employee.lastName}",
              ),
              DataGridCell<String>(
                columnName: 'email',
                value: "${employee.email}",
              ),
              DataGridCell<String>(
                columnName: 'date',
                value: DateFormat('dd/MM/yy').format(employee.registrationDate),
              ),
              DataGridCell<bool>(
                columnName: 'admin',
                value: employee.admin,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
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
