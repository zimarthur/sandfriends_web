import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../SharedComponents/View/SFHeader.dart';
import '../../../../SharedComponents/View/SFTabs.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import 'dart:io';

import '../ViewModel/HelpViewModel.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final HelpViewModel viewModel = HelpViewModel();

  int _selectedTile = -1;

  @override
  Widget build(BuildContext context) {
    double width =
        Provider.of<DashboardViewModel>(context).getDashboardWidth(context);
    double height =
        Provider.of<DashboardViewModel>(context).getDashboardHeigth(context);
    return ChangeNotifierProvider<HelpViewModel>(
      create: (BuildContext context) => viewModel,
      child: Consumer<HelpViewModel>(
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
                        header: "Ajuda",
                        description:
                            "Tire suas dúvidas ou fale com a nossa equipe",
                      ),
                    ),
                    SFButton(
                      buttonLabel: "Conversar com o suporte",
                      buttonType: ButtonType.Primary,
                      onTap: () {
                        viewModel.talkSupport(context);
                      },
                      textPadding: const EdgeInsets.symmetric(
                        vertical: defaultPadding,
                        horizontal: defaultPadding * 2,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2 * defaultPadding,
                ),
                Text(
                  "Perguntas frequentes",
                  style: const TextStyle(
                    color: textBlack,
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 2 * defaultPadding,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: viewModel.faqItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ExpansionTile(
                          title: Text(
                            viewModel.faqItems[index].question,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textBlack,
                            ),
                          ),
                          backgroundColor: secondaryPaper,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius)),
                          childrenPadding: EdgeInsets.all(defaultPadding),
                          children: [
                            ListTile(
                              title: Text(viewModel.faqItems[index].answer),
                            )
                          ],
                        ),
                        SizedBox(
                          height: defaultPadding,
                        )
                      ],
                    );
                  },
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
