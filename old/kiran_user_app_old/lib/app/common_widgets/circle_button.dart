import 'package:flutter/material.dart';

class CustomCircleButtton extends StatelessWidget {
  const CustomCircleButtton(
      {Key? key, this.color, this.splashColor, this.onTap, this.child})
      : super(key: key);
  final Color? color;
  final Color? splashColor;
  final void Function()? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: child,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
        primary: color, // <-- Button color
        onPrimary: splashColor, // <-- Splash color
      ),
    );
  }
}
