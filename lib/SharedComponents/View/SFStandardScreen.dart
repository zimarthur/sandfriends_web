import 'package:flutter/material.dart';
import 'package:sandfriends_web/SharedComponents/ViewModel/EnvironmentProvider.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:sandfriends_web/Utils/PageStatus.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Utils/Responsive.dart';
import 'SFLoading.dart';
import 'SFMessageModal.dart';

class SFStandardScreen extends StatefulWidget {
  PageStatus pageStatus;
  Widget childWeb;
  Widget childMobile;
  Widget? modalFormWidget;
  SFMessageModal? messageModalWidget;
  Widget? drawer;
  Key? scaffoldKey;

  SFStandardScreen({
    required this.pageStatus,
    required this.childWeb,
    required this.childMobile,
    this.modalFormWidget,
    this.messageModalWidget,
    this.drawer,
    this.scaffoldKey,
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
      backgroundColor: primaryBlue,
      endDrawer: widget.drawer,
      key: widget.scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primaryBlue, primaryLightBlue],
                ),
              ),
              height: height,
              width: width,
              child: Center(
                child: Responsive.isMobile(context)
                    ? widget.childMobile
                    : widget.childWeb,
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
            if (Provider.of<EnvironmentProvider>(context).currentEnvironment !=
                Environment.Prod)
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  Provider.of<EnvironmentProvider>(context)
                              .currentEnvironment ==
                          Environment.Dev
                      ? "DEV"
                      : "DEMO",
                  style: TextStyle(
                    fontSize: 20,
                    backgroundColor: textWhite,
                    color:
                        Provider.of<EnvironmentProvider>(context, listen: false)
                                    .currentEnvironment ==
                                Environment.Dev
                            ? red
                            : primaryBlue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
