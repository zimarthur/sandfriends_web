import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Home/View/OnboardingCheckItem.dart';
import 'package:sandfriends_web/Features/Home/ViewModel/HomeViewModel.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/MenuProvider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OnboardingWidget extends StatelessWidget {
  HomeViewModel viewModel;
  OnboardingWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, layoutConstraits) {
      return Container(
        height: 300,
        width: layoutConstraits.maxWidth,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryPaper,
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
          ),
          boxShadow: const [
            BoxShadow(
              color: divider,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                r"assets/people/onboarding.svg",
                height: 220,
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Seja bem-vindo ao sandfriends!",
                    style: TextStyle(
                      color: textBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    "Preencha as informações essenciais do seu estabelecimento para começar para começar a receber agendamentos.",
                    style: TextStyle(
                      color: textDarkGrey,
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OnboardingCheckItem(
                              title: "Criar uma conta",
                              isChecked: true,
                              onTap: () {},
                            ),
                            OnboardingCheckItem(
                              title:
                                  "Adicionar o logo e fotos do seu estabelecimento",
                              isChecked: viewModel.brandingSet(context),
                              onTap: () {
                                // Provider.of<MenuProvider>(context,
                                //         listen: false)
                                //     .quickLinkBrand();
                              },
                            ),
                            OnboardingCheckItem(
                              title:
                                  "Inserir uma descrição para o seu estabelecimento",
                              isChecked: viewModel.storeDescriptionSet(context),
                              onTap: () {
                                // Provider.of<MenuProvider>(context,
                                //         listen: false)
                                //     .quickLinkBrand();
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OnboardingCheckItem(
                              title: "Cadastrar dados bancários",
                              isChecked: false,
                              onTap: () {
                                // Provider.of<MenuProvider>(context,
                                //         listen: false)
                                //     .quickLinkFinanceSettings();
                              },
                            ),
                            OnboardingCheckItem(
                              title: "Configurar o horário de funcionamento",
                              isChecked: viewModel.opDaysSet(context),
                              onTap: () {
                                // Provider.of<MenuProvider>(context,
                                //         listen: false)
                                //     .quickLinkWorkingHours();
                              },
                            ),
                            OnboardingCheckItem(
                              title: "Cadastrar suas quadras",
                              isChecked: viewModel.courtsSet(context),
                              onTap: () {
                                // Provider.of<MenuProvider>(context,
                                //         listen: false)
                                //     .onTabClick(4, context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
