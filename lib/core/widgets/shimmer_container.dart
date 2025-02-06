import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../app_colors.dart';

class ShimmerContainer extends StatelessWidget {
  final BorderRadius borderRadius;
  final double? height;
  const ShimmerContainer({super.key, required this.borderRadius, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Container(
        decoration: BoxDecoration(color: const Color(0xffEFF8E3), borderRadius: borderRadius),
        height: height,
        width: double.infinity,
      ),
    );
  }
}
