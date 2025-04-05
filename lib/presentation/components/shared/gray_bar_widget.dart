import 'package:flutter/material.dart';

class GrayBarWidget extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const GrayBarWidget({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: SizedBox(),
      ),
    );
  }
}