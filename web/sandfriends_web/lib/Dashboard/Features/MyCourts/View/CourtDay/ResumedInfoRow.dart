import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDropDown.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class ResumedInfoRow extends StatefulWidget {
  String day;
  String workingHours;
  bool allowRecurrentMatch;
  String priceRange;
  bool isEditing;
  double rowHeight;

  ResumedInfoRow({
    required this.day,
    required this.workingHours,
    required this.allowRecurrentMatch,
    required this.priceRange,
    required this.isEditing,
    required this.rowHeight,
  });
  @override
  State<ResumedInfoRow> createState() => _ResumedInfoRowState();
}

class _ResumedInfoRowState extends State<ResumedInfoRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            widget.day,
            style: TextStyle(color: textDarkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            widget.workingHours,
            style: TextStyle(color: textDarkGrey),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.center,
            child: widget.isEditing
                ? SizedBox(
                    height: widget.rowHeight * 0.7,
                    child: SFDropdown(
                      labelText: "Sim",
                      items: ["Sim", "Não"],
                      validator: (value) {},
                      onChanged: (value) {
                        if (value == "Sim") {
                        } else {
                          widget.allowRecurrentMatch = false;
                        }
                      },
                      textColor: textDarkGrey,
                      enableBorder: true,
                    ),
                  )
                : Text(
                    widget.allowRecurrentMatch ? "Sim" : "Não",
                    style: TextStyle(color: textDarkGrey),
                  ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            widget.priceRange,
            style: TextStyle(color: textDarkGrey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
