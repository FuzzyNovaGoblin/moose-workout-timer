import 'package:flutter/material.dart';
import 'package:moose_timer/HomePage.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        accentColor: Colors.white,
        // backgroundColor: Colors.black,
        // scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 5, color: Colors.black)),
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.black)),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.black38,
          selectionHandleColor: Colors.black,
        ),
      ),
    );
  }
}

main(List<String> args) {
  runApp(BaseApp());
}
