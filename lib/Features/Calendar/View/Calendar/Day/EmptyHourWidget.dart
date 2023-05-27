import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyHourWidget extends StatefulWidget {
  VoidCallback onBlockHour;
  bool isEnabled;
  EmptyHourWidget({
    required this.isEnabled,
    required this.onBlockHour,
  });

  @override
  State<EmptyHourWidget> createState() => _EmptyHourWidgetState();
}

class _EmptyHourWidgetState extends State<EmptyHourWidget> {
  bool buttonExpanded = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layourContext, layoutConstraints) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          border: Border.all(
            color: divider,
            width: 1,
          ),
          color: widget.isEnabled ? divider.withOpacity(0.3) : divider,
        ),
        margin: EdgeInsets.symmetric(
            vertical: defaultPadding / 4, horizontal: defaultPadding / 2),
        width: double.infinity,
        height: layoutConstraints.maxHeight,
        child: Row(
          children: [
            Expanded(
              child: Container(),
            ),
            if (widget.isEnabled)
              InkWell(
                onTap: widget.onBlockHour,
                onHover: (value) {
                  setState(() {
                    buttonExpanded = value;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    color: textWhite,
                  ),
                  padding: EdgeInsets.all(layoutConstraints.maxHeight * 0.1),
                  margin: EdgeInsets.only(
                    right: defaultPadding,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        r"assets/icon/block.svg",
                        color: red,
                      ),
                      if (buttonExpanded)
                        Row(
                          children: [
                            SizedBox(
                              width: layoutConstraints.maxHeight * 0.1,
                            ),
                            Text(
                              "Bloquear Horário",
                              style: TextStyle(color: red),
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
