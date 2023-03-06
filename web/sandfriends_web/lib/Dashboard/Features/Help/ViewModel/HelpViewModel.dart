import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image/image.dart' as IMG;
import 'package:image_picker/image_picker.dart';
import 'package:sandfriends_web/Dashboard/Features/Help/View/TalkToSupport.dart';
import '../../../../Utils/SFImage.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/DashboardViewModel.dart';
import '../Model/Faq.dart';

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
    Provider.of<DashboardViewModel>(context, listen: false).setModalForm(
      TalkToSupportWidget(),
    );
  }

  void returnMainView(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false).setModalSuccess();
  }
}
