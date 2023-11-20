import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Home/View/Web/NotificationCard.dart';
import 'package:sandfriends_web/Features/Home/View/Web/NotificationWidget.dart';
import 'package:sandfriends_web/Features/Home/ViewModel/HomeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/SharedComponents/Model/AppNotification.dart';
import 'package:sandfriends_web/SharedComponents/View/SFStandardScreen.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({
    super.key,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<AppNotification> notifications = [];

  @override
  void initState() {
    notifications =
        Provider.of<DataProvider>(context, listen: false).notifications;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).hasUnseenNotifications =
          false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: primaryBlue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                      width: width * 0.15,
                      height: 60,
                      child: Center(
                        child: SvgPicture.asset(
                          r"assets/icon/arrow_left.svg",
                          color: textWhite,
                          width: 25,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Últimas atualizações",
                      style: TextStyle(color: textWhite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.15,
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: secondaryBack,
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: notifications.isEmpty
                  ? Center(
                      child: Text(
                        "Você não tem notificações",
                        style: TextStyle(
                          color: textDarkGrey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationCard(
                            notification: notifications[index]);
                      },
                    ),
            ))
          ],
        ),
      ),
    );
  }
}
