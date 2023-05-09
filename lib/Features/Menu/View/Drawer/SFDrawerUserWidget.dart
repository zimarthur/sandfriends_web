import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Menu/View/Drawer/SFDrawerPopup.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFDrawerUserWidget extends StatefulWidget {
  bool fullSize;
  Function(int) onTap;

  SFDrawerUserWidget({super.key, required this.fullSize, required this.onTap});

  @override
  State<SFDrawerUserWidget> createState() => _SFDrawerUserWidgetState();
}

class _SFDrawerUserWidgetState extends State<SFDrawerUserWidget> {
  bool isOnHover = false;
  @override
  Widget build(BuildContext context) {
    return widget.fullSize
        ? Row(
            children: [
              CircleAvatar(
                backgroundColor: textWhite,
                radius: 25,
                child: CircleAvatar(
                  radius: 23,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: Image.asset(
                        r"assets/Arthur.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              const Text(
                "Beach Brasil",
                style: TextStyle(color: textWhite),
              ),
              Expanded(
                child: Container(),
              ),
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    if (value == true) {
                      isOnHover = true;
                    } else {
                      isOnHover = false;
                    }
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: isOnHover
                        ? primaryDarkBlue.withOpacity(0.3)
                        : primaryBlue,
                    borderRadius: BorderRadius.circular(
                      defaultBorderRadius,
                    ),
                  ),
                  child: SFDrawerPopup(
                    onTap: (value) {
                      widget.onTap(value);
                    },
                    showIcon: true,
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              CircleAvatar(
                backgroundColor: textWhite,
                radius: 25,
                child: CircleAvatar(
                  radius: 23,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: Image.asset(
                        r"assets/Arthur.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    if (value == true) {
                      isOnHover = true;
                    } else {
                      isOnHover = false;
                    }
                  });
                },
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isOnHover
                          ? textDarkGrey.withOpacity(0.8)
                          : Colors.transparent,
                    ),
                    child: SFDrawerPopup(
                      onTap: (value) {
                        widget.onTap(value);
                      },
                      showIcon: isOnHover,
                    )),
              ),
            ],
          );
  }
}
