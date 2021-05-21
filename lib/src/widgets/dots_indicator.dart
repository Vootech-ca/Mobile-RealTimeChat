import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: AppColors.lightSecondaryColor,
    this.selectedIndex : 0,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  final int selectedIndex;

// The base size of the dots
  static const double _kDotSize = 16.0;

// The distance between the center of each dot
  static const double _kDotSpacing = 20.0;

  Widget _buildDot(int index) {
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == selectedIndex ? AppColors.lightSecondaryColor : Colors.white,
              border: Border.all(width:0.5)),
          width: _kDotSize,
          height: _kDotSize,
          child: new InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
