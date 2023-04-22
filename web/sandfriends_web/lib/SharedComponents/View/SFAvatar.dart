import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SFAvatar extends StatefulWidget {
  final double height;
  final String img;

  const SFAvatar({super.key, required this.height, required this.img});

  @override
  State<SFAvatar> createState() => _SFAvatarState();
}

class _SFAvatarState extends State<SFAvatar> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height * 0.42),
        child: SvgPicture.asset(
          widget.img,
        ),
      ),
    );
  }
}
