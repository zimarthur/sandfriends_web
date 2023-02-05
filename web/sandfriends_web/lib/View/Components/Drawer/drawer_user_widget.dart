import 'package:flutter/material.dart';
import 'package:sandfriends_web/Resources/constants.dart';
import 'package:sandfriends_web/View/Components/SF_Avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SFDrawerUserWidget extends StatefulWidget {
  bool fullSize;

  SFDrawerUserWidget({required this.fullSize});

  @override
  State<SFDrawerUserWidget> createState() => _SFDrawerUserWidgetState();
}

class _SFDrawerUserWidgetState extends State<SFDrawerUserWidget> {
  bool isOnHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        onHover: (value) {
          setState(() {
            if (value == true)
              isOnHover = true;
            else
              isOnHover = false;
          });
        },
        child: widget.fullSize
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
                decoration: BoxDecoration(
                  color: isOnHover
                      ? primaryDarkBlue.withOpacity(0.3)
                      : primaryBlue,
                  borderRadius: BorderRadius.circular(
                    defaultBorderRadius,
                  ),
                ),
                child: Row(
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
                    SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "Beach Brasil",
                      style: TextStyle(color: textWhite),
                    )
                  ],
                ),
              )
            : CircleAvatar(
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
              ));
  }
}
