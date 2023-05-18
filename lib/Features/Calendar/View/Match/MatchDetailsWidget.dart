import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/Model/PaymentType.dart';
import 'package:sandfriends_web/Features/Calendar/View/Match/MatchDetailsWidgetRow.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDivider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:provider/provider.dart';
import '../../../../SharedComponents/View/SFButton.dart';
import '../../../Menu/ViewModel/MenuProvider.dart';

class MatchDetailsWidget extends StatelessWidget {
  CalendarViewModel viewModel;

  MatchDetailsWidget({super.key, required this.viewModel});
  TextEditingController controller = TextEditingController();
  PaymentType paymentStatus = PaymentType.NeedsPayment;

  @override
  Widget build(BuildContext context) {
    controller.text = "Precisamos de raquetes";
    double width = Provider.of<MenuProvider>(context).getScreenWidth(context);
    double height = Provider.of<MenuProvider>(context).getScreenHeight(context);
    return Container(
      height: height * 0.9,
      width: 500,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Partida agendada",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: textBlue),
                  ),
                  const SizedBox(
                    height: 2 * defaultPadding,
                  ),
                  MatchDetailsWidgetRow(
                    title: "Criador",
                    customValue: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                r"assets/Arthur.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        const Text(
                          "Arthur Zim",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  MatchDetailsWidgetRow(title: "Dia", value: "07/04/2023"),
                  MatchDetailsWidgetRow(
                      title: "Horário", value: "16:00 - 17:00"),
                  MatchDetailsWidgetRow(title: "Esporte", value: "Beach tenis"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SFDivider(),
                  ),
                  MatchDetailsWidgetRow(
                    title: "Recado de Arthur",
                    customValue: SFTextField(
                      labelText: "",
                      pourpose: TextFieldPourpose.Multiline,
                      minLines: 4,
                      maxLines: 4,
                      controller: controller,
                      validator: (a) {
                        return null;
                      },
                      enable: false,
                    ),
                    fixedHeight: false,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: SFDivider(),
                  ),
                  MatchDetailsWidgetRow(
                      title: "Status",
                      customValue: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding / 4,
                                horizontal: defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: paymentStatus == PaymentType.Paid
                                  ? paidBackground
                                  : needsPaymentBackground,
                              borderRadius: BorderRadius.circular(
                                defaultBorderRadius,
                              ),
                            ),
                            child: Text(
                              paymentStatus == PaymentType.Paid
                                  ? "Pago"
                                  : "Pagar no local",
                              style: TextStyle(
                                color: paymentStatus == PaymentType.Paid
                                    ? paidText
                                    : needsPaymentText,
                              ),
                            ),
                          ),
                        ],
                      )),
                  MatchDetailsWidgetRow(
                    title: "Preço",
                    value: "R\$100,00",
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SFButton(
                  buttonLabel: "Voltar",
                  buttonType: ButtonType.Secondary,
                  onTap: () {
                    viewModel.returnMainView(context);
                  },
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                child: SFButton(
                  buttonLabel: "Cancelar partida",
                  buttonType: ButtonType.Delete,
                  onTap: () {
                    viewModel.setMatchCancelWidget(context, viewModel);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}