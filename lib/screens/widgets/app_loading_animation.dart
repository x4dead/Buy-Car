import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingAnimation extends StatelessWidget {
  const AppLoadingAnimation({
    Key? key,
    required this.leftDotColor,
    required this.rightDotColor,
  }) : super(key: key);

  final Color leftDotColor;
  final Color rightDotColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: leftDotColor,
        rightDotColor: rightDotColor,
        size: 32,
      ),
    );
  }
}
