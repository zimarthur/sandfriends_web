import 'package:flutter/material.dart';
import 'package:sandfriends_web/Resources/constants.dart';

class HourWidget extends StatefulWidget {
  int hourIndex;
  int columnIndex;
  int hoveredHour;
  int hoveredColumn;
  double height;
  double width;
  Function(bool) onChanged;

  HourWidget(this.hourIndex, this.columnIndex, this.hoveredHour,
      this.hoveredColumn, this.height, this.width, this.onChanged);
  @override
  State<HourWidget> createState() => _HourWidgetState();
}

class _HourWidgetState extends State<HourWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        widget.onChanged(value);
      },
      child: Container(
        width: widget.width * 0.6,
        height: widget.height * 0.7,
        decoration: BoxDecoration(
          color: divider,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: widget.hourIndex == widget.hoveredHour &&
                widget.columnIndex == widget.hoveredColumn
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: textDarkGrey,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: widget.height * 0.6,
                  color: textWhite,
                ),
              )
            : Container(),
      ),
    );
  }
}
