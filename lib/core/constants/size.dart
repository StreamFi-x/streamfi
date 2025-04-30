import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Config {
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIos => Platform.isIOS;

  static double horizontalMargin(BuildContext context, double height) {
    var viewPortHeight = MediaQuery.of(context).size.longestSide;
    viewPortHeight = viewPortHeight > 950 ? 950 : viewPortHeight;
    return height * (viewPortHeight / 100);
  }

  static double verticalMargin(BuildContext context, double width) {
    var viewPortwidth = MediaQuery.of(context).size.shortestSide;
    viewPortwidth = viewPortwidth > 650 ? 650 : viewPortwidth;
    return width * (viewPortwidth / 100);
  }

}

extension CustomContext on BuildContext {
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}

class HorizontalMargin extends StatelessWidget {
  const HorizontalMargin(this.x, {super.key});
  final double x;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x.sp);
  }
}

class VerticalMargin extends StatelessWidget {
  const VerticalMargin(this.y, {super.key});
  final double y;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y.sp);
  }
}
