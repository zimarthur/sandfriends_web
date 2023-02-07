import 'package:flutter/material.dart';
import 'package:sandfriends_web/constants.dart';

class SFHeader extends StatelessWidget {
  final String header;
  final String description;

  SFHeader({required this.header, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: defaultPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              color: textBlack,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: textDarkGrey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
