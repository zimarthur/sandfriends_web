import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Menu/ViewModel/MenuProvider.dart';
import '../Model/Faq.dart';
import '../View/TalkToSupportWidget.dart';

class HelpViewModel extends ChangeNotifier {
  List<Faq> faqItems = [
    Faq(
        question: "Como agendar uma partida?",
        answer:
            "Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, "),
    Faq(
        question: "Preciso cancelar uma partida, o que eu faço?",
        answer:
            "Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, "),
    Faq(
        question: "Configurar o preço de mensalista",
        answer:
            "Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, Assim, Assado, "),
  ];

  void talkSupport(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).setModalForm(
      TalkToSupportWidget(),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<MenuProvider>(context, listen: false).closeModal();
  }
}
