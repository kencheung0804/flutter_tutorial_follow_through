import 'package:flutter/material.dart';

class ShownText extends StatelessWidget {
  final String text;

  const ShownText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
