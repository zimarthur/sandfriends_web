import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/MyCourts/ViewModel/MyCourtsViewModel.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFTabs.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'dart:io';

class MyCourtsScreen extends StatefulWidget {
  const MyCourtsScreen({super.key});

  @override
  State<MyCourtsScreen> createState() => _MyCourtsScreenState();
}

class _MyCourtsScreenState extends State<MyCourtsScreen> {
  final MyCourtsViewModel viewModel = MyCourtsViewModel();

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return ChangeNotifierProvider<MyCourtsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<MyCourtsViewModel>(
        builder: (context, viewModel, _) {
          return Container(
            color: secondaryBack,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: SFHeader(
                        header: "Minhas quadras",
                        description:
                            "Configure as quadras do seu estabelecimento!",
                      ),
                    ),
                    SFButton(
                      buttonLabel: "Horário de funcionamento",
                      buttonType: ButtonType.Primary,
                      onTap: () {
                        viewModel.setWorkingHours(context);
                      },
                      textPadding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding * 2,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
