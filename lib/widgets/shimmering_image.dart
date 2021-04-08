import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringImage extends StatelessWidget {
  final double _boxWidth, _boxHeight;

  ShimmeringImage(this._boxWidth, this._boxHeight);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: SizedBox(
        width: _boxWidth,
        height: _boxHeight,
        child: const DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}
