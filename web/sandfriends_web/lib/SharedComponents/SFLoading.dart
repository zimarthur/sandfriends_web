import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sandfriends_web/Utils/Constants.dart';

class SFLoading extends StatelessWidget {
  double size;
  SFLoading({required this.size});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LoadingAnimationWidget.flickr(
      leftDotColor: primaryBlue,
      rightDotColor: secondaryYellow,
      size: size,
    );
  }
}
