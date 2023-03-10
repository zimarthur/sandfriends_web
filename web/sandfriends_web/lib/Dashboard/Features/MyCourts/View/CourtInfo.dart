import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class CourtInfo extends StatefulWidget {
  const CourtInfo({super.key});

  @override
  State<CourtInfo> createState() => _CourtInfoState();
}

class _CourtInfoState extends State<CourtInfo> {
  List<String> courtTypeValues = ["Coberto", "Descoberto"];
  String courtType = "Coberto";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: secondaryBack,
          border: Border.all(
            color: primaryBlue,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(defaultBorderRadius)),
      margin: EdgeInsets.all(defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: Text(
                "Informações",
                style: TextStyle(
                  color: primaryBlue,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: defaultPadding),
              child: SFDivider(),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Nome",
                    style: TextStyle(
                      color: textDarkGrey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      // RadioListTile(
                      //   value: "Coberto",
                      //   groupValue: courtType,
                      //   onChanged: (value) {
                      //     courtType = value!;
                      //   },
                      // ),
                      // RadioListTile(
                      //   value: "Descoberto",
                      //   groupValue: courtType,
                      //   onChanged: (value) {
                      //     courtType = value!;
                      //   },
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
