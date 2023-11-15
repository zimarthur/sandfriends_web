import 'package:flutter/material.dart';

import '../../../../Utils/Constants.dart';
import '../../ViewModel/MenuProvider.dart';
import 'Header.dart';

class MenuWidgetMobile extends StatefulWidget {
  MenuProvider viewModel;
  MenuWidgetMobile({required this.viewModel, super.key});

  @override
  State<MenuWidgetMobile> createState() => _MenuWidgetMobileState();
}

class _MenuWidgetMobileState extends State<MenuWidgetMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MobileHeader(viewModel: widget.viewModel),
        Expanded(
          child: widget.viewModel.selectedDrawerItem.widget,
        )
      ],
    );
  }
}
