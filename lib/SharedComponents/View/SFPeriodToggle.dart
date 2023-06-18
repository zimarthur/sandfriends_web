import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/EnumPeriodVisualization.dart';
import 'package:sandfriends_web/SharedComponents/View/SFToggle.dart';

class SFPeriodToggle extends StatefulWidget {
  EnumPeriodVisualization currentPeriodVisualization;
  Function(EnumPeriodVisualization) onChanged;
  String? customText;
  SFPeriodToggle({
    required this.currentPeriodVisualization,
    required this.onChanged,
    this.customText,
  });

  @override
  State<SFPeriodToggle> createState() => _SFPeriodToggleState();
}

class _SFPeriodToggleState extends State<SFPeriodToggle> {
  @override
  Widget build(BuildContext context) {
    return SFToggle(
      [
        "Hoje",
        "Nesse mês",
        widget.currentPeriodVisualization == EnumPeriodVisualization.Custom
            ? widget.customText!
            : "Personalizado"
      ],
      widget.currentPeriodVisualization.index,
      (newPeriod) => widget.onChanged(
        EnumPeriodVisualization.values.elementAt(
          newPeriod,
        ),
      ),
    );
  }
}
