import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: "QR Code Scanner",
      home: Home(),
    );
  }
}
