import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandfriends_web/Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SFStorePhoto extends StatelessWidget {
  Uint8List image;
  VoidCallback delete;

  SFStorePhoto({
    required this.image,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 190,
          width: 320,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                child: Image.memory(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: delete,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryBlue,
                    ),
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      r'assets/icon/x.svg',
                      color: secondaryPaper,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 2 * defaultPadding,
        )
      ],
    );
  }
}
