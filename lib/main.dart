import 'package:flutter/material.dart';
import 'package:flutter_metamask_connect/metamask.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple, // background (button) color
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
            elevation: 0,

            // foreground (text) color
          ),
        ),
      ),
      home: const MatamaskScreen(),
    );
  }
}
