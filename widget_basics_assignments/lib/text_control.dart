import 'package:flutter/material.dart';

class TextControlButton extends StatelessWidget {
  final VoidCallback changeText;

  const TextControlButton(this.changeText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
            // style: ButtonStyle(
            //   foregroundColor: MaterialStateProperty.all(Colors.black),
            //   backgroundColor: MaterialStateProperty.all(Colors.orange),
            // ),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange, onPrimary: Colors.black),
            onPressed: changeText,
            child: const Text("Complete Test")));
  }
}
