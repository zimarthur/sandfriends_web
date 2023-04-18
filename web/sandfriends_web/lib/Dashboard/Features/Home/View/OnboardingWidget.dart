import 'package:flutter/material.dart';
import 'package:sandfriends_web/Dashboard/Features/Home/View/OnboardingCheckItem.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, layoutConstraits) {
      return Container(
        height: 300,
        width: layoutConstraits.maxWidth,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryPaper,
          borderRadius: BorderRadius.circular(
            defaultBorderRadius,
          ),
          boxShadow: [
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seja bem-vindo ao sandfriends!",
                    style: TextStyle(
                      color: textBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
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
                              isChecked: false,
                              onTap: () {},
                            ),
                            OnboardingCheckItem(
                              title:
                                  "Inserir uma descrição para o seu estabelecimento",
                              isChecked: false,
                              onTap: () {},
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
                              onTap: () {},
                            ),
                            OnboardingCheckItem(
                              title: "Configurar o horário de funcionamento",
                              isChecked: false,
                              onTap: () {},
                            ),
                            OnboardingCheckItem(
                              title: "Cadastrar suas quadras",
                              isChecked: false,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ],
              ),
              flex: 2,
            ),
          ],
        ),
      );
    });
  }
}
