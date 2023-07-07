import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Home/ViewModel/HomeViewModel.dart';

import '../../../Utils/Constants.dart';
import 'NotificationCard.dart';

class NotificationWidget extends StatelessWidget {
  HomeViewModel viewModel;
  NotificationWidget({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutContext, layoutConstraints) {
      return Container(
        height: layoutConstraints.maxHeight,
        width: layoutConstraints.maxWidth,
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 2,
          horizontal: defaultPadding,
        ),
        decoration: BoxDecoration(
          color: secondaryPaper,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Últimas atualizações",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textDarkGrey,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.notifications.length,
                itemBuilder: (context, index) {
                  return NotificationCard(
                    notification: viewModel.notifications[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
