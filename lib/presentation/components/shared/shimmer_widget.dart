import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;

  const ShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: SellPointColors.shimmerGray,
      highlightColor: Colors.white,
      child: child,
    );
  }
}