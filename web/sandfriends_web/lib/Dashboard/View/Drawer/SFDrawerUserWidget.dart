import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFDrawerUserWidget extends StatefulWidget {
  bool fullSize;
  VoidCallback onTap;

  SFDrawerUserWidget({required this.fullSize, required this.onTap});

  @override
  State<SFDrawerUserWidget> createState() => _SFDrawerUserWidgetState();
}

class _SFDrawerUserWidgetState extends State<SFDrawerUserWidget> {
  bool isOnHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          if (value == true) {
            isOnHover = true;
          } else {
            isOnHover = false;
          }
        });
      },
      child: widget.fullSize
          ? Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              decoration: BoxDecoration(
                color:
                    isOnHover ? primaryDarkBlue.withOpacity(0.3) : primaryBlue,
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
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  const Text(
                    "Beach Brasil",
                    style: TextStyle(color: textWhite),
                  ),
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
            ),
    );
  }
}