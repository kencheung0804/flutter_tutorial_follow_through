// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text
import 'package:flutter/material.dart';

import 'shown_text.dart';
import 'text_control.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _shownText = "Testing";

  void _changeText() {
    setState(() {
      _shownText = "Test Done!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text("Test App")),
            body: Column(
              children: [ShownText(_shownText), TextControlButton(_changeText)],
              mainAxisAlignment: MainAxisAlignment.center,
            )));
  }
}
