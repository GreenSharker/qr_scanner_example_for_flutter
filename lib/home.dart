import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/scanner.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanenr"),
      ),
      body: Center(
        child: Text(
          _result != null ? _result! : "데이터 없음",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openScanner,
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }

  Future _openScanner() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Scanner()));
    setState(() {
      _result = result;
    });
  }
}
