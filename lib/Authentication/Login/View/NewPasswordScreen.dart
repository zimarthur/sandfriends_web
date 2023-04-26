// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:sandfriends_web/Authentication/Login/View/LoginScreen.dart';
// import 'package:sandfriends_web/SharedComponents/View/SFButton.dart';
// import 'package:sandfriends_web/SharedComponents/View/SFTextfield.dart';
// import 'package:sandfriends_web/Utils/Constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:sandfriends_web/Utils/PageStatus.dart';

// import '../../../SharedComponents/View/SFLoading.dart';
// import '../../../SharedComponents/View/SFMessageModal.dart';

// final _newPasswordFormKey = GlobalKey<FormState>();

// class NewPasswordScreen extends StatefulWidget {
//   const NewPasswordScreen({super.key});

//   @override
//   State<NewPasswordScreen> createState() => _NewPasswordScreenState();
// }

// class _NewPasswordScreenState extends State<NewPasswordScreen> {
//   TextEditingController newPassword = TextEditingController();
//   TextEditingController confirmNewPassword = TextEditingController();

//   String requestToken = "123";

//   PageStatus status = PageStatus.SUCCESS;

//   String responseString = "";
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Container(
//               color: primaryBlue.withOpacity(0.4),
//               width: width,
//               height: height,
//               child: Center(
//                 child: status == PageStatus.LOADING
//                     ? Container(
//                         height: 300,
//                         width: 300,
//                         child: SFLoading(size: 80),
//                       )
//                     : status == PageStatus.SUCCESS
//                         ? Container(
//                             padding: const EdgeInsets.all(2 * defaultPadding),
//                             width: width * 0.3 < 350 ? 350 : width * 0.3,
//                             decoration: BoxDecoration(
//                               color: secondaryPaper,
//                               borderRadius:
//                                   BorderRadius.circular(defaultBorderRadius),
//                               border: Border.all(
//                                 color: divider,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Form(
//                               key: _newPasswordFormKey,
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Criar nova senha",
//                                       style: TextStyle(
//                                           color: textBlue,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: defaultPadding / 2,
//                                     ),
//                                     Text(
//                                       "Digite sua nova senha de acesso ao sandfriends",
//                                       style: TextStyle(
//                                         color: textDarkGrey,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 2 * defaultPadding,
//                                     ),
//                                     SFTextField(
//                                         labelText: "Nova senha",
//                                         pourpose: TextFieldPourpose.Password,
//                                         controller: newPassword,
//                                         suffixIcon: SvgPicture.asset(
//                                             r"assets/icon/eye_closed.svg"),
//                                         suffixIconPressed: SvgPicture.asset(
//                                             r"assets/icon/eye_open.svg"),
//                                         validator: (a) {
//                                           if (newPassword.text.length < 8) {
//                                             return "Sua senha deve ter pelo menos 8 caracteres";
//                                           }
//                                         }),
//                                     SizedBox(
//                                       height: defaultPadding,
//                                     ),
//                                     SFTextField(
//                                       labelText: "Repetir nova senha",
//                                       pourpose: TextFieldPourpose.Password,
//                                       controller: confirmNewPassword,
//                                       suffixIcon: SvgPicture.asset(
//                                           r"assets/icon/eye_closed.svg"),
//                                       suffixIconPressed: SvgPicture.asset(
//                                           r"assets/icon/eye_open.svg"),
//                                       validator: (a) {
//                                         if (newPassword.text !=
//                                             confirmNewPassword.text) {
//                                           return "As senhas não estão iguais";
//                                         }
//                                       },
//                                     ),
//                                     SizedBox(
//                                       height: 2 * defaultPadding,
//                                     ),
//                                     SFButton(
//                                       buttonLabel: "Salvar",
//                                       buttonType: ButtonType.Primary,
//                                       onTap: () {
//                                         if (_newPasswordFormKey.currentState
//                                                 ?.validate() ==
//                                             true) {
//                                           SaveNewPassword(context);
//                                         }
//                                       },
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           )
//                         : SFMessageModal(
//                             title: responseString,
//                             description: "",
//                             onTap: () {
//                               if (status == PageStatus.ERROR) {
//                                 setState(() {
//                                   status = PageStatus.SUCCESS;
//                                 });
//                               } else {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const LoginScreen()),
//                                 );
//                               }
//                             },
//                             isHappy: status == PageStatus.ERROR ? false : true,
//                           ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> SaveNewPassword(BuildContext context) async {
//     setState(() {
//       status = PageStatus.LOADING;
//     });
//     var response = await http.post(
//       Uri.parse('https://www.sandfriends.com.br/ChangePasswordStore'),
//       headers: <String, String>{'Content-Type': 'application/json'},
//       body: jsonEncode(
//         <String, Object>{
//           'resetPasswordToken': requestToken,
//           'newPassword': newPassword.text,
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         status = PageStatus.ACCOMPLISHED;
//         responseString = response.body;
//       });
//     } else {
//       setState(() {
//         status = PageStatus.ERROR;
//         responseString = response.body;
//       });
//     }
//   }
// }
