import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  final String imgUrl;
  final double size;

  const MyCircleAvatar({
    Key key,
    @required this.imgUrl,
    this.size = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.3), offset: Offset(0, 2), blurRadius: 5)],
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage("$imgUrl"),
      ),
    );
  }
}
