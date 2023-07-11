import 'package:flutter/material.dart';

class WidgetHeroAnimation extends StatelessWidget {
  const WidgetHeroAnimation({ Key? key, required this.child, required this.onTap, required this.tag, }) : super(key: key);

  final Widget child;
  final String tag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}