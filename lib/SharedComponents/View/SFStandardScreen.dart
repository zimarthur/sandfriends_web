import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';

import 'SFLoading.dart';
import 'SFMessageModal.dart';

class SFStandardScreen extends StatefulWidget {
  PageStatus pageStatus;
  Widget child;
  Widget? modalFormWidget;
  SFMessageModal? messageModalWidget;

  SFStandardScreen({
    required this.pageStatus,
    required this.child,
    this.modalFormWidget,
    this.messageModalWidget,
  });

  @override
  State<SFStandardScreen> createState() => _SFStandardScreenState();
}

class _SFStandardScreenState extends State<SFStandardScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Text('
            //     "testes",
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
            Container(
              color: primaryBlue.withOpacity(0.4),
              height: height,
              width: width,
              child: Center(
                child: widget.child,
              ),
            ),
            widget.pageStatus != PageStatus.OK
                ? Container(
                    color: primaryBlue.withOpacity(0.4),
                    height: height,
                    width: width,
                    child: Center(
                      child: widget.pageStatus == PageStatus.LOADING
                          ? SizedBox(
                              height: 300,
                              width: 300,
                              child: SFLoading(size: 80),
                            )
                          : widget.pageStatus == PageStatus.FORM
                              ? widget.modalFormWidget
                              : widget.messageModalWidget,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
