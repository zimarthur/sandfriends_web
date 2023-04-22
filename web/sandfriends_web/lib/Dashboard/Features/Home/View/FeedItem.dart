import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        r"assets/Arthur.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'Arthur agendou uma ',
                          style: TextStyle(
                            color: textDarkGrey,
                            fontFamily: 'Lexend',
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'nova partida',
                              style: TextStyle(
                                color: textBlue,
                                fontFamily: 'Lexend',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            r"assets/icon/calendar.svg",
                            color: textDarkGrey,
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          const Text(
                            "07/04/2023",
                            style: TextStyle(
                              color: textDarkGrey,
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding * 2,
                          ),
                          SvgPicture.asset(
                            r"assets/icon/clock.svg",
                            color: textDarkGrey,
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          const Text(
                            "11:00 - 12:00",
                            style: TextStyle(
                              color: textDarkGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                const Text(
                  "12/04/23\n14:28",
                  style: TextStyle(
                    color: textLightGrey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            color: divider,
            height: 1,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
