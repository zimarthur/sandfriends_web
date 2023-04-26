import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFDivider extends StatelessWidget {
  const SFDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: divider,
    );
  }
}
