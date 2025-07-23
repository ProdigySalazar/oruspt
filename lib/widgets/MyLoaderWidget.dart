import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyLoaderWidget extends StatelessWidget {
  final double size;
  final Color? color;

  const MyLoaderWidget({super.key, this.size = 40.0, this.color});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(
      color: color ?? Colors.indigo,
      size: size,
    );
  }
}
