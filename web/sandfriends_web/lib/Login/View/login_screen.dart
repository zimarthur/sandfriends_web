import 'package:flutter/material.dart';
import 'package:sandfriends_web/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sandfriends_web/View/Components/SF_Button.dart';
import 'package:sandfriends_web/View/Components/SF_Textfield.dart';
import 'package:provider/provider.dart';
import '../ViewModel/LoginViewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: primaryBlue.withOpacity(0.4),
              height: height,
              width: width,
              child: Center(
                child: Provider.of<LoginViewModel>(context).loginWidget,
              ),
            ),
            Provider.of<LoginViewModel>(context).showModal
                ? Container(
                    color: primaryBlue.withOpacity(0.4),
                    height: height,
                    width: width,
                    child: Center(
                      child: Provider.of<LoginViewModel>(context).modalWidget!,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
