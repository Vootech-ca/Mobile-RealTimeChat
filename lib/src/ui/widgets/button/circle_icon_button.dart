import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback callback;
  final Color color;
  final double size;
  final double iconSize;
  final Color iconColor;
  final double tapRadius;

  CircleIconButton({
    @required this.icon,
    @required this.callback,
    @required this.color,
    this.size = 52.0,
    this.iconSize = 23.0,
    this.iconColor = AppColors.primaryColor,
    this.tapRadius = 32.0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(tapRadius)),
          onTap: () {
            callback();
          },
          child: Center(
            child: Icon(icon, size: iconSize, color: iconColor),
          ),
        ),
      ),
    );
  }
}
