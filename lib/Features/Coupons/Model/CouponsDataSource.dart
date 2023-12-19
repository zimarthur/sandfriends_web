import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Players/Model/PlayersTableCallback.dart';
import 'package:sandfriends_web/Features/Settings/EmployeeInfo/Model/EmployeeTableCallbacks.dart';
import 'package:sandfriends_web/SharedComponents/Model/Coupon.dart';
import 'package:sandfriends_web/SharedComponents/Model/Employee.dart';
import 'package:sandfriends_web/SharedComponents/Model/EnumCouponStatus.dart';
import 'package:sandfriends_web/SharedComponents/Model/Player.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/TypesExtensions.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CouponsTableCallback.dart';

class CouponsDataSource extends DataGridSource {
  CouponsDataSource({
    required List<Coupon> coupons,
    required Function(CouponsTableCallback, Coupon, BuildContext) tableCallback,
    required BuildContext context,
  }) {
    _coupons = coupons
        .map<DataGridRow>(
          (coupon) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'couponCode',
                value: coupon.couponCode,
              ),
              DataGridCell<String>(
                columnName: 'couponValue',
                value: coupon.valueText,
              ),
              DataGridCell<Text>(
                columnName: 'validDates',
                value: Text(
                  "${DateFormat("dd/MM/yy").format(
                    coupon.startingDate,
                  )} - ${DateFormat("dd/MM/yy").format(
                    coupon.endingDate,
                  )}\n${coupon.endingDate.difference(coupon.startingDate).inDays} dia(s)",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              DataGridCell<String>(
                columnName: 'validHour',
                value:
                    "${coupon.hourBegin.hourString} - ${coupon.hourEnd.hourString}",
              ),
              DataGridCell<Widget>(
                columnName: "status",
                value: couponStatus(
                  coupon,
                ),
              ),
              DataGridCell<String>(
                columnName: 'timesUsed',
                value: coupon.timesUsed.toString(),
              ),
              DataGridCell<Text>(
                columnName: 'profit',
                value: Text(
                  coupon.profit.formatPrice(),
                  style: TextStyle(
                    color: coupon.profit > 0 ? greenText : null,
                    fontWeight: coupon.profit > 0 ? FontWeight.bold : null,
                  ),
                ),
              ),
              DataGridCell<Widget>(
                columnName: 'actions',
                value: action(coupon, tableCallback, context),
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _coupons = [];

  @override
  List<DataGridRow> get rows => _coupons;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 48,
              child: dataGridCell.value is Widget
                  ? dataGridCell.value
                  : Text(
                      dataGridCell.value.toString(),
                      overflow: TextOverflow.ellipsis,
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

  Widget couponStatus(Coupon coupon) {
    return Container(
      decoration: BoxDecoration(
        color: coupon.couponStatus.textBg,
        borderRadius: BorderRadius.circular(
          defaultBorderRadius,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: defaultPadding / 2,
        horizontal: defaultPadding,
      ),
      child: Text(
        coupon.couponStatus.text,
        style: TextStyle(
          color: coupon.couponStatus.textColor,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget action(
    Coupon coupon,
    Function(CouponsTableCallback, Coupon, BuildContext) callback,
    BuildContext context,
  ) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      icon: SvgPicture.asset(
        r'assets/icon/three_dots.svg',
        height: 14,
        color: textDarkGrey,
      ),
      tooltip: "",
      itemBuilder: (BuildContext context) {
        List<PopupMenuItem> items = [];
        print(!coupon.isValid);
        print(DateTime.now().isAfter(coupon.endDateTime));
        print(!coupon.isDateExpired);
        if (coupon.couponStatus == EnumCouponStatus.Valid ||
            coupon.couponStatus == EnumCouponStatus.Unavailable) {
          items.add(PopupMenuItem(
            value: CouponsTableCallback.Disable,
            child: Row(
              children: [
                SvgPicture.asset(
                  r"assets/icon/delete.svg",
                  color: red,
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                Text(
                  'Dasabilitar',
                  style: TextStyle(
                    color: red,
                  ),
                ),
              ],
            ),
          ));
        }
        if (!coupon.isValid &&
            (!coupon.isDateExpired ||
                DateTime.now().isAfter(coupon.endDateTime))) {
          items.add(
            PopupMenuItem(
              value: CouponsTableCallback.Enable,
              child: Row(
                children: [
                  SvgPicture.asset(
                    r"assets/icon/check.svg",
                    color: textDarkGrey,
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Text(
                    'Habilitar',
                    style: TextStyle(
                      color: textDarkGrey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return items;
      },
      elevation: 2,
      onSelected: (value) => callback(value, coupon, context),
    );
  }
}
