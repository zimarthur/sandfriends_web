import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Calendar/ViewModel/CalendarViewModel.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/Coupon.dart';
import 'package:sandfriends_web/SharedComponents/Model/EnumDiscountType.dart';
import 'package:sandfriends_web/SharedComponents/Model/Gender.dart';
import 'package:sandfriends_web/SharedComponents/Model/Rank.dart';
import 'package:sandfriends_web/SharedComponents/View/SFDropDown.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';
import 'package:sandfriends_web/Utils/Validators.dart';
import 'package:provider/provider.dart';
import '../../../../../SharedComponents/Model/Court.dart';
import '../../../../../SharedComponents/Model/Hour.dart';
import '../../../../../SharedComponents/Model/Sport.dart';
import '../../../../../SharedComponents/View/SFButton.dart';
import '../../../../../SharedComponents/View/SFTextfield.dart';
import '../../../../../Utils/Constants.dart';
import '../../../../SharedComponents/Model/Player.dart';

class AddCouponModal extends StatefulWidget {
  VoidCallback onReturn;
  Function(Coupon) onCreateCoupon;

  AddCouponModal({
    required this.onReturn,
    required this.onCreateCoupon,
  });

  @override
  State<AddCouponModal> createState() => _AddCouponModalState();
}

class _AddCouponModalState extends State<AddCouponModal> {
  String couponCode = "";
  EnumDiscountType discountType = EnumDiscountType.Fixed;
  int couponValue = 0;
  DateTime? startDate;
  DateTime? endDate;

  List<Hour> availableHours = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController couponController = TextEditingController();
  TextEditingController couponValueController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    availableHours =
        Provider.of<DataProvider>(context, listen: false).availableHours;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: Responsive.isMobile(context) ? width * 0.95 : 500,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryPaper,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(
          color: divider,
          width: 1,
        ),
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Criar novo cupom",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: textBlue,
                ),
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Text(
                "Alavanque suas vendas e faça com que novos jogadores conheçam sua quadras com cupons de desconto",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: textDarkGrey,
                ),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Row(
                children: [
                  const Expanded(flex: 1, child: Text("Nome do cupom:")),
                  Expanded(
                    flex: 2,
                    child: SFTextField(
                      labelText: "",
                      hintText: "SAND10",
                      pourpose: TextFieldPourpose.Standard,
                      controller: couponController,
                      onChanged: (newName) {
                        setState(() {
                          couponCode = newName;
                        });
                      },
                      validator: (a) => emptyCheck(a, "Digite o nome do cupom"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(flex: 2, child: Text("Valor do cupom:")),
                  Expanded(
                    flex: 1,
                    child: SFTextField(
                      labelText: "",
                      pourpose: TextFieldPourpose.Numeric,
                      controller: couponValueController,
                      validator: (a) {},
                      textAlign: TextAlign.center,
                      prefixText:
                          discountType == EnumDiscountType.Fixed ? "R\$" : null,
                      sufixText: discountType == EnumDiscountType.Percentage
                          ? "%"
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => setState(() {
                      discountType = EnumDiscountType.Fixed;
                    }),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          defaultBorderRadius,
                        ),
                        border: discountType == EnumDiscountType.Fixed
                            ? Border.all(color: primaryBlue, width: 2)
                            : Border.all(
                                color: divider,
                              ),
                        color: discountType == EnumDiscountType.Fixed
                            ? blueBg
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          "R\$",
                          style: TextStyle(
                            color: discountType == EnumDiscountType.Fixed
                                ? blueText
                                : textDarkGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding / 2,
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      discountType = EnumDiscountType.Percentage;
                    }),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          defaultBorderRadius,
                        ),
                        border: discountType == EnumDiscountType.Percentage
                            ? Border.all(color: primaryBlue, width: 2)
                            : Border.all(
                                color: divider,
                              ),
                        color: discountType == EnumDiscountType.Percentage
                            ? blueBg
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          "%",
                          style: TextStyle(
                            color: discountType == EnumDiscountType.Percentage
                                ? blueText
                                : textDarkGrey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(flex: 2, child: Text("Valor do cupom:")),
                  Expanded(
                    flex: 1,
                    child: SFTextField(
                      labelText: "",
                      pourpose: TextFieldPourpose.Numeric,
                      controller: couponValueController,
                      validator: (a) {},
                      textAlign: TextAlign.center,
                      prefixText:
                          discountType == EnumDiscountType.Fixed ? "R\$" : null,
                      sufixText: discountType == EnumDiscountType.Percentage
                          ? "%"
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                children: [
                  Expanded(child: Text("Data de validade:")),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: defaultPadding / 2,
                      horizontal: defaultPadding,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        defaultBorderRadius,
                      ),
                      border: startDate != null && endDate != null
                          ? Border.all(color: primaryBlue, width: 2)
                          : Border.all(
                              color: divider,
                            ),
                      color:
                          startDate != null && endDate != null ? blueBg : null,
                    ),
                    child: Center(
                      child: Text(
                        startDate != null && endDate != null
                            ? ""
                            : "Selecionar data",
                        style: TextStyle(
                          color: startDate != null && endDate != null
                              ? blueText
                              : textDarkGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2 * defaultPadding,
              ),
              Row(
                children: [
                  Expanded(
                    child: SFButton(
                      buttonLabel: "Voltar",
                      buttonType: ButtonType.Secondary,
                      onTap: widget.onReturn,
                    ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                    child: SFButton(
                      buttonLabel: "Adicionar cupom",
                      buttonType: ButtonType.Primary,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
