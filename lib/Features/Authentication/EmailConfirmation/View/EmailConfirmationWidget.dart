import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Authentication/EmailConfirmation/ViewModel/EmailConfirmationViewModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../../Utils/Constants.dart';
import '../../../../Utils/Responsive.dart';

class EmailConfirmationWidget extends StatelessWidget {
  EmailConfirmationViewModel viewModel;
  EmailConfirmationWidget({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(2 * defaultPadding),
      width: Responsive.isMobile(context)
          ? width * 0.8
          : width * 0.3 < 350
              ? 350
              : width * 0.3,
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            viewModel.isStoreRequest
                ? r"assets/people/email_confirmation_store.svg"
                : r"assets/people/email_confirmation_user.svg",
            height: Responsive.isMobile(context) ? height * 0.4 : 150,
          ),
          const SizedBox(
            height: 2 * defaultPadding,
          ),
          Text(
            "Parabéns, sua conta foi criada!",
            style: TextStyle(
                color: textBlack,
                fontSize: Responsive.isMobile(context) ? 18 : 24),
          ),
          const SizedBox(
            height: defaultPadding / 2,
          ),
          Text(
            viewModel.isStoreRequest
                ? "Em breve entraremos em contato para apresentar a plataforma e todas suas funcionalidades.\nQualquer dúvida, basta chamar nossa equipe de suporte."
                : "Entre no app e comece a agendar suas partidas",
            style: TextStyle(
              color: textDarkGrey,
              fontSize: Responsive.isMobile(context) ? 14 : 16,
            ),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
        ],
      ),
    );
  }
}
