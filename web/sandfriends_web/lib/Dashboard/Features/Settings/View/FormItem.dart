import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

import '../../../../SharedComponents/View/SFTextfield.dart';

class FormItem extends StatelessWidget {
  String name;
  TextEditingController controller;
  bool controllerEnabled;
  bool hasSecondItem;
  String? secondName;
  TextEditingController? secondController;
  Widget? customWidget;

  FormItem({
    required this.name,
    required this.controller,
    this.controllerEnabled = true,
    this.hasSecondItem = false,
    this.secondName,
    this.secondController,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                color: textDarkGrey,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 2,
            child: SFTextField(
              controller: controller,
              labelText: '',
              pourpose: TextFieldPourpose.Standard,
              validator: (String? value) {},
              enable: controllerEnabled,
            ),
          ),
          Expanded(
            flex: 3,
            child: hasSecondItem
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2 * defaultPadding),
                    child: customWidget ??
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                secondName!,
                                style: TextStyle(
                                  color: textDarkGrey,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SFTextField(
                                controller: secondController!,
                                labelText: '',
                                pourpose: TextFieldPourpose.Standard,
                                validator: (String? value) {},
                              ),
                            ),
                          ],
                        ))
                : Container(),
          ),
        ],
      ),
    );
  }
}
