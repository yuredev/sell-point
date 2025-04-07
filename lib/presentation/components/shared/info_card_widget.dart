import 'package:flutter/material.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final EdgeInsets padding;

  const InfoCardWidget({
    super.key,
    required this.title,
    required this.description,
    this.padding = const EdgeInsets.symmetric(
      horizontal: Sizes.defaultHorizontalPadding,
      vertical: 16,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      color: AppColors.backgroundGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              color: AppColors.textLightBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textLightBlack,
            ),
          ),
        ],
      ),
    );
  }
}