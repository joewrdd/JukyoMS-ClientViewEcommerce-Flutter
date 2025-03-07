import 'package:flutter/material.dart';
import 'package:jukyo_ms/common/widgets/custom/shapes/curved_edges.dart';

class CustomCurvedEdgesWidget extends StatelessWidget {
  const CustomCurvedEdgesWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdges(), child: child);
  }
}
