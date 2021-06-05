import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class BusyIndicator extends StatelessWidget {
  Color color;
  final double size;
  final bool isInCenter;

  BusyIndicator({
    this.color,
    this.size = 48.0,
    this.isInCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      color = AppColors.secondaryColor;
    }
    if (isInCenter) {
      return Center(
        child: SpinKitChasingDots(size: size, color: color),
      );
    } else {
      return SpinKitChasingDots(size: size, color: color);
    }
  }
}
