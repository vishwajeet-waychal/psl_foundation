import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 5,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black
      ),
    );
  }
}
